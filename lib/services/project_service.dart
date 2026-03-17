import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/project_model.dart';

class ProjectService {
  static const String _projectsRoot = '/storage/emulated/0/Documents/WebBlocks/Projects';

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) return true;
      var status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
    return true;
  }

  Future<Directory> _getDir() async {
    final dir = Directory(_projectsRoot);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// Loyihalarni papkalar strukturasidan yig'ib olish
  Future<List<Project>> getProjects() async {
    try {
      if (!await _requestPermission()) return [];
      
      final rootDir = await _getDir();
      final List<Project> projects = [];

      final List<FileSystemEntity> entities = await rootDir.list().toList();
      for (var entity in entities) {
        if (entity is Directory) {
          final String projectName = entity.path.split('/').last;
          // Har bir loyiha papkasi ichida .metadata.json fayli bo'ladi (ID va boshqa ma'lumotlar uchun)
          final metadataFile = File('${entity.path}/.metadata.json');
          
          if (await metadataFile.exists()) {
            final content = await metadataFile.readAsString();
            final project = Project.fromJson(jsonDecode(content));
            
            // Fayllarni jismoniy holatiga qarab yangilaymiz (sinxronizatsiya)
            project.files = await _scanFiles(entity, null);
            projects.add(project);
          }
        }
      }
      return projects..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } catch (e) {
      print('Loyihalarni yuklashda xatolik: $e');
      return [];
    }
  }

  /// Papka ichidagi fayllarni skanerlash
  Future<List<ProjectFile>> _scanFiles(Directory dir, String? parentId) async {
    final List<ProjectFile> files = [];
    final List<FileSystemEntity> entities = await dir.list().toList();
    
    for (var entity in entities) {
      final name = entity.path.split('/').last;
      if (name.startsWith('.')) continue; // Yashirin fayllarni o'tkazib yuboramiz

      if (entity is Directory) {
        final folderId = name.hashCode.toString();
        files.add(ProjectFile(id: folderId, name: name, isFolder: true, parentId: parentId));
        files.addAll(await _scanFiles(entity, folderId));
      } else if (entity is File) {
        final content = await entity.readAsString();
        
        // Blockly XML ma'lumotlarini saqlash uchun alohida yashirin .xml fayllarni o'qiymiz
        String xmlContent = '';
        final xmlFile = File('${dir.path}/.$name.xml');
        if (await xmlFile.exists()) {
          xmlContent = await xmlFile.readAsString();
        }

        files.add(ProjectFile(
          id: name.hashCode.toString(),
          name: name,
          codeContent: content,
          xmlContent: xmlContent,
          parentId: parentId,
        ));
      }
    }
    return files;
  }

  Future<void> saveProject(Project project) async {
    try {
      if (!await _requestPermission()) return;

      final projectPath = '$_projectsRoot/${project.name}';
      final projectDir = Directory(projectPath);
      if (!await projectDir.exists()) await projectDir.create(recursive: true);

      // 1. Metadata saqlash
      final metadataFile = File('$projectPath/.metadata.json');
      await metadataFile.writeAsString(jsonEncode(project.toJson()));

      // 2. Fayllarni yozish
      for (var file in project.files) {
        if (file.isFolder) {
          await Directory('$projectPath/${file.name}').create(recursive: true);
        } else {
          final f = File('$projectPath/${file.name}');
          await f.writeAsString(file.codeContent);
          
          // Agar XML bo'lsa, uni yashirin faylda saqlaymiz (sinxronlik uchun)
          if (file.xmlContent.isNotEmpty) {
            final xmlFile = File('$projectPath/.${file.name}.xml');
            await xmlFile.writeAsString(file.xmlContent);
          }
        }
      }
    } catch (e) {
      print('Saqlashda xatolik: $e');
    }
  }

  Future<void> deleteProject(String id, String name) async {
    final dir = Directory('$_projectsRoot/$name');
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}
