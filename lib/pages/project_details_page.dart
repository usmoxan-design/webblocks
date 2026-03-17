import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart'; 
import '../models/project_model.dart';
import '../services/project_service.dart';
import 'editor_page.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late Project _project;
  late WebViewController _previewController;
  String? _currentFolderId; 
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
    _tabController = TabController(length: 2, vsync: this);
    _initPreviewController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProject();
    });

    _tabController.addListener(() {
      if (_tabController.index == 1 && !_tabController.indexIsChanging) {
        _updatePreview();
      }
    });
  }

  Future<void> _refreshProject() async {
    setState(() => _isLoading = true);
    final projects = await ProjectService().getProjects();
    final updatedProject = projects.firstWhere((p) => p.id == _project.id, orElse: () => _project);
    setState(() {
      _project = updatedProject;
      _isLoading = false;
    });
    _updatePreview();
  }

  void _initPreviewController() {
    _previewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_buildDefaultHtml());
  }

  Future<void> _updatePreview() async {
    final indexFile = _project.files.firstWhere(
      (f) => f.name.toLowerCase() == 'index.html', 
      orElse: () => _project.files.firstWhere(
        (f) => f.name.toLowerCase().endsWith('.html'), 
        orElse: () => ProjectFile(id: '', name: '')
      )
    );
    final styleFile = _project.files.firstWhere((f) => f.name.toLowerCase() == 'style.css', orElse: () => ProjectFile(id: '', name: ''));
    final scriptFile = _project.files.firstWhere((f) => f.name.toLowerCase() == 'script.js', orElse: () => ProjectFile(id: '', name: ''));

    String html = indexFile.codeContent;
    if (html.isEmpty) {
       html = _buildDefaultHtml();
    } else {
      if (styleFile.codeContent.isNotEmpty) {
        if (html.contains('</head>')) {
           html = html.replaceFirst('</head>', '<style>\n${styleFile.codeContent}\n</style>\n</head>');
        } else {
           html += '<style>\n${styleFile.codeContent}\n</style>';
        }
      }
      if (scriptFile.codeContent.isNotEmpty) {
         if (html.contains('</body>')) {
           html = html.replaceFirst('</body>', '<script>\n${scriptFile.codeContent}\n</script>\n</body>');
         } else {
           html += '<script>\n${scriptFile.codeContent}\n</script>';
         }
      }
    }
    
    await _previewController.loadHtmlString(html);
  }

  String _buildDefaultHtml() {
    return '<html><body style="background:#F8F9FA;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;font-family:sans-serif;color:#5F6368;"><div><h2 style="color:#1A73E8;text-align:center;">WebBlocks</h2><p>Loyiha bo\'sh</p></div></body></html>';
  }

  void _showCreateDialog({bool isFolder = false}) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(isFolder ? 'Yangi papka' : 'Yangi fayl', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(
            hintText: isFolder ? 'assets' : 'index.html',
            border: const UnderlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Bekor', style: TextStyle(color: Color(0xFF5F6368)))),
          TextButton(
            onPressed: () async {
              final name = ctrl.text.trim();
              if (name.isNotEmpty) {
                if (_project.files.any((f) => f.name.toLowerCase() == name.toLowerCase() && f.parentId == _currentFolderId)) {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bunday nomli fayl/papka mavjud!')));
                   return;
                }
                Navigator.pop(ctx);
                setState(() {
                  _project.files.add(ProjectFile(
                    id: const Uuid().v4(),
                    name: name,
                    isFolder: isFolder,
                    parentId: _currentFolderId,
                  ));
                  _project.updatedAt = DateTime.now();
                });
                await ProjectService().saveProject(_project);
                _refreshProject();
              }
            },
            child: const Text('Yaratish', style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _importFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any, allowMultiple: false);
      if (result != null) {
        PlatformFile file = result.files.first;
        String content = '';
        final extension = file.extension?.toLowerCase();
        if (['html', 'css', 'js', 'txt', 'json'].contains(extension)) {
          if (file.path != null) content = await File(file.path!).readAsString();
        } else {
          content = '[Media file: $extension]';
        }
        setState(() {
          _project.files.add(ProjectFile(id: const Uuid().v4(), name: file.name, codeContent: content, parentId: _currentFolderId));
          _project.updatedAt = DateTime.now();
        });
        await ProjectService().saveProject(_project);
        _refreshProject();
      }
    } catch (e) {}
  }

  void _showRenameDialog(ProjectFile file) {
    final ctrl = TextEditingController(text: file.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Nomini o\'zgartirish', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: TextField(controller: ctrl, autofocus: true, decoration: const InputDecoration(border: UnderlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Bekor')),
          TextButton(
            onPressed: () async {
              final newName = ctrl.text.trim();
              if (newName.isNotEmpty && newName != file.name) {
                setState(() {
                  final idx = _project.files.indexWhere((f) => f.id == file.id);
                  if (idx != -1) _project.files[idx].name = newName;
                });
                await ProjectService().saveProject(_project);
                Navigator.pop(ctx);
                _refreshProject();
              }
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(ProjectFile file) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('${file.name} o\'chirilsinmi?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Bekor')),
          TextButton(
            onPressed: () async {
              setState(() => _project.files.removeWhere((f) => f.id == file.id));
              await ProjectService().saveProject(_project);
              Navigator.pop(ctx);
              _refreshProject();
            },
            child: const Text('O\'chirish', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _openFile(ProjectFile file) async {
    if (file.isFolder) {
      setState(() => _currentFolderId = file.id);
      return;
    }
    final updatedFile = await Navigator.push(context, MaterialPageRoute(builder: (_) => EditorPage(project: _project, file: file)));
    if (updatedFile != null && updatedFile is ProjectFile) {
      setState(() {
        final idx = _project.files.indexWhere((f) => f.id == file.id);
        if (idx != -1) _project.files[idx] = updatedFile;
      });
      await ProjectService().saveProject(_project);
      _refreshProject();
    }
  }

  String _getFileSize(String content) {
    final bytes = utf8.encode(content).length;
    if (bytes < 1024) return '$bytes Bayt';
    return '${(bytes / 1024).toStringAsFixed(1)} KB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_project.name, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(controller: _tabController, indicatorColor: const Color(0xFF1A73E8), labelColor: const Color(0xFF1A73E8), tabs: const [Tab(text: 'Fayllar'), Tab(text: 'Natija')]),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RefreshIndicator(
            onRefresh: _refreshProject,
            child: _buildFilesList(),
          ),
          WebViewWidget(controller: _previewController)
        ],
      ),
    );
  }

  Widget _buildFilesList() {
    final filteredFiles = _project.files.where((f) => f.parentId == _currentFolderId).toList();
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_currentFolderId == null ? 'Loyiha' : 'Papka', style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.upload_file, color: Color(0xFF1A73E8)), onPressed: _importFile),
                  IconButton(icon: const Icon(Icons.create_new_folder, color: Color(0xFF1A73E8)), onPressed: () => _showCreateDialog(isFolder: true)),
                  IconButton(icon: const Icon(Icons.note_add, color: Color(0xFF1A73E8)), onPressed: () => _showCreateDialog(isFolder: false)),
                ],
              ),
            ],
          ),
        ),
        if (_currentFolderId != null)
          ListTile(
            leading: const Icon(Icons.arrow_upward), 
            title: const Text('Orqaga'), 
            onTap: () {
              final current = _project.files.firstWhere((f) => f.id == _currentFolderId);
              setState(() => _currentFolderId = current.parentId);
            }
          ),
        Expanded(
          child: filteredFiles.isEmpty 
            ? const Center(child: Text('Bo\'sh'))
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(), // Refresh indicator ishlashi uchun
                itemCount: filteredFiles.length,
                itemBuilder: (context, index) {
                  final file = filteredFiles[index];
                  return ListTile(
                    leading: Icon(file.isFolder ? Icons.folder : Icons.insert_drive_file, color: file.isFolder ? Colors.orange : Colors.blue),
                    title: Text(file.name),
                    subtitle: Text(file.isFolder ? 'Papka' : _getFileSize(file.codeContent)),
                    trailing: PopupMenuButton<String>(
                      onSelected: (v) => v == 'rename' ? _showRenameDialog(file) : _confirmDelete(file),
                      itemBuilder: (ctx) => [const PopupMenuItem(value: 'rename', child: Text('Nomlash')), const PopupMenuItem(value: 'delete', child: Text('O\'chirish'))],
                    ),
                    onTap: () => _openFile(file),
                  );
                },
              ),
        ),
      ],
    );
  }
}
