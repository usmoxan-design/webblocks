import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';
import '../data/templates.dart';
import 'project_details_page.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final TextEditingController _projectNameController = TextEditingController();
  final ProjectService _service = ProjectService();
  ProjectTemplate _selectedTemplate = ProjectTemplate.blank;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Yangi Loyiha',
          style: GoogleFonts.inter(
            color: const Color(0xFF1A73E8),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A73E8)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Project Name Input
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFDADCE0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Loyiha nomi',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1A73E8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _projectNameController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Loyiha nomini kiriting',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF1A73E8), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Template Selection
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFDADCE0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Shablon tanlash',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1A73E8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...ProjectTemplate.values
                        .map((template) => _buildTemplateCard(template))
                        .toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Create Button
            ElevatedButton(
              onPressed: _createProject,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Loyihani yaratish',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(ProjectTemplate template) {
    bool isSelected = _selectedTemplate == template;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTemplate = template;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F0FE) : Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color(0xFF1A73E8) : const Color(0xFFDADCE0),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Radio<ProjectTemplate>(
              value: template,
              groupValue: _selectedTemplate,
              onChanged: (value) {
                setState(() {
                  _selectedTemplate = value!;
                });
              },
              activeColor: const Color(0xFF1A73E8),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                template.name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF3C4043),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createProject() async {
    final projectName = _projectNameController.text.trim();

    if (projectName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Loyiha nomini kiriting!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Check if project name already exists
    final existingProjects = await _service.getProjects();
    bool exists = existingProjects.any(
      (p) => p.name.toLowerCase() == projectName.toLowerCase(),
    );

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bunday nomli loyiha allaqachon mavjud!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create new project
      final project = Project(
        id: const Uuid().v4(),
        name: projectName,
        files: [
          ProjectFile(
            id: const Uuid().v4(),
            name: 'index.html',
            xmlContent: _selectedTemplate.xmlContent,
            codeContent: _selectedTemplate.htmlContent,
          ),
          ProjectFile(
            id: const Uuid().v4(),
            name: 'style.css',
            xmlContent: _selectedTemplate.cssXmlContent,
            codeContent: _selectedTemplate.cssContent,
          ),
          ProjectFile(
            id: const Uuid().v4(),
            name: 'script.js',
            xmlContent: _selectedTemplate.jsXmlContent,
            codeContent: _selectedTemplate.jsContent,
          ),
          ProjectFile(
            id: const Uuid().v4(),
            name: 'assets',
            isFolder: true,
          ),
        ],
      );

      await _service.saveProject(project);

      if (!mounted) return;

      // Navigate to project details page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectDetailsPage(project: project),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Loyiha yaratishda xatolik: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
