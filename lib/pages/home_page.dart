import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';
import 'project_details_page.dart';
import 'block_maker_page.dart';
import 'tutorial_page.dart';
import '../data/templates.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProjectService _service = ProjectService();
  List<Project> _projects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermissions();
    });
    _loadProjects();
  }

  Future<void> _checkPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    bool isPermissionAsked = prefs.getBool('permission_asked') ?? false;

    // Agar ruxsat berilgan bo'lsa yoki allaqachon so'ralgan bo'lsa, qaytib chiqamiz
    if (await Permission.manageExternalStorage.isGranted || await Permission.storage.isGranted) {
      return;
    }

    if (!isPermissionAsked) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Ruxsat so\'ralmoqda'),
          content: const Text('WebBlocks loyihalarni tashqi xotirada (/WebBlocks/Projects) saqlashi uchun fayllarga kirish ruxsati kerak. Iltimos, ruxsat bering.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Bekor qilish', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A73E8), foregroundColor: Colors.white),
              onPressed: () async {
                Navigator.pop(ctx);
                await prefs.setBool('permission_asked', true);

                // Haqiqiy ruxsat so'rash oynasini ochish
                if (Platform.isAndroid) {
                  // Android 11+ uchun manageExternalStorage, pastdagilar uchun storage
                  if (await Permission.manageExternalStorage.request().isGranted ||
                      await Permission.storage.request().isGranted) {
                    _loadProjects(); // Ruxsat berilgach loyihalarni qayta yuklash
                  } else {
                    // Agar ruxsat berilmasa, sozlamalarga yo'naltirish mumkin
                    openAppSettings();
                  }
                }
              },
              child: const Text('Ruxsat berish'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _loadProjects() async {
    setState(() => _isLoading = true);
    final projects = await _service.getProjects();
    setState(() {
      _projects = projects;
      _isLoading = false;
    });
  }

  void _showCreateDialog() {
    final ctrl = TextEditingController();
    ProjectTemplate selectedTemplate = ProjectTemplate.blank;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogContext, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Yangi loyiha',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: ctrl,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Loyiha nomi',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<ProjectTemplate>(
                    value: selectedTemplate,
                    isExpanded: true, 
                    decoration: const InputDecoration(
                      labelText: 'Shablon turi',
                      border: OutlineInputBorder(),
                    ),
                    items: ProjectTemplate.values.map((template) {
                      return DropdownMenuItem(
                        value: template,
                        child: Text(template.name, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedTemplate = val);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Bekor',
                      style: TextStyle(color: Color(0xFF5F6368)))),
              TextButton(
                onPressed: () async {
                  final name = ctrl.text.trim();
                  if (name.isEmpty) return;

                  bool exists = _projects.any((p) => p.name.toLowerCase() == name.toLowerCase());
                  if (exists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bunday nomli loyiha allaqachon mavjud!'), backgroundColor: Colors.orange)
                    );
                    return;
                  }

                  Navigator.pop(ctx);
                  final project = Project(id: const Uuid().v4(), name: name, files: [
                    ProjectFile(
                        id: const Uuid().v4(),
                        name: 'index.html',
                        xmlContent: selectedTemplate.xmlContent,
                        codeContent: selectedTemplate.htmlContent),
                    ProjectFile(
                        id: const Uuid().v4(), 
                        name: 'style.css',
                        xmlContent: selectedTemplate.cssXmlContent,
                        codeContent: selectedTemplate.cssContent),
                    ProjectFile(
                        id: const Uuid().v4(), 
                        name: 'script.js',
                        xmlContent: selectedTemplate.jsXmlContent,
                        codeContent: selectedTemplate.jsContent),
                    ProjectFile(
                        id: const Uuid().v4(), name: 'assets', isFolder: true),
                  ]);
                  await _service.saveProject(project);
                  if (!mounted) return;
                  Navigator.push(
                          context, // Endi HomePage konteksti ishlatiladi
                          MaterialPageRoute(
                              builder: (_) =>
                                  ProjectDetailsPage(project: project)))
                      .then((_) => _loadProjects());
                },
                child: const Text('Yaratish',
                    style: TextStyle(
                        color: Color(0xFF1A73E8), fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
      ),
    );
  }

  void _showRenameDialog(Project project) {
    final ctrl = TextEditingController(text: project.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Loyihani qayta nomlash',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(border: UnderlineInputBorder()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Bekor',
                  style: TextStyle(color: Color(0xFF5F6368)))),
          TextButton(
            onPressed: () async {
              final newName = ctrl.text.trim();
              if (newName.isNotEmpty && newName != project.name) {
                if (_projects.any((p) => p.name.toLowerCase() == newName.toLowerCase() && p.id != project.id)) {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bunday nomli loyiha mavjud!')));
                   return;
                }
                Navigator.pop(ctx);
                project.name = newName;
                project.updatedAt = DateTime.now();
                await _service.saveProject(project);
                _loadProjects();
              } else {
                Navigator.pop(ctx);
              }
            },
            child: const Text('Saqlash',
                style: TextStyle(
                    color: Color(0xFF1A73E8), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Project project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('${project.name} o\'chirilsinmi?',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: const Text('Bu amalni ortga qaytarib bo\'lmaydi.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Bekor',
                  style: TextStyle(color: Color(0xFF5F6368)))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _service.deleteProject(project.id, project.name);
              _loadProjects();
            },
            child: const Text('O\'chirish',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('WebBlocks',
            style: GoogleFonts.inter(
                color: const Color(0xFF1A73E8),
                fontWeight: FontWeight.w700,
                fontSize: 22)),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded,
                color: Color(0xFF1A73E8)),
            tooltip: 'Qo\'llanma',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TutorialPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.build_circle_outlined,
                color: Color(0xFF1A73E8)),
            tooltip: 'Block Maker',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BlockMakerPage()));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadProjects,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _projects.isEmpty
                ? Stack(children: [ListView(), _buildEmptyState()])
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: _projects.length,
                    itemBuilder: (context, index) =>
                        _buildProjectItem(_projects[index]),
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A73E8),
        icon: const Icon(Icons.add),
        label: const Text('Yangi loyiha'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.web_asset_off, size: 80, color: Color(0xFFDADCE0)),
          const SizedBox(height: 16),
          Text('Loyihalar hali yo\'q',
              style: GoogleFonts.inter(
                  fontSize: 18, color: const Color(0xFF5F6368))),
        ],
      ),
    );
  }

  Widget _buildProjectItem(Project project) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDADCE0)),
      ),
      child: ListTile(
        leading: const CircleAvatar(
            backgroundColor: Color(0xFFE8F0FE),
            child: Icon(Icons.code, color: Color(0xFF1A73E8))),
        title: Text(project.name,
            style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
        subtitle: Text(
            'Oxirgi tahrir: ${project.updatedAt.day}.${project.updatedAt.month}.${project.updatedAt.year}',
            style: const TextStyle(fontSize: 12)),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded, color: Color(0xFFBDC1C6)),
          onSelected: (val) {
            if (val == 'rename') _showRenameDialog(project);
            if (val == 'delete') _confirmDelete(project);
          },
          itemBuilder: (ctx) => [
            const PopupMenuItem(
                value: 'rename',
                child: Row(children: [
                  Icon(Icons.edit_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Nomini o\'zgartirish')
                ])),
            const PopupMenuItem(
                value: 'delete',
                child: Row(children: [
                  Icon(Icons.delete_outline_rounded,
                      color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text('O\'chirish', style: TextStyle(color: Colors.red))
                ])),
          ],
        ),
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProjectDetailsPage(project: project)))
              .then((_) => _loadProjects());
        },
      ),
    );
  }
}
