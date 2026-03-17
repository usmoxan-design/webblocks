class ProjectFile {
  final String id;
  String name;
  final bool isFolder;
  String xmlContent;
  String codeContent;
  final String? parentId;
  DateTime updatedAt;

  ProjectFile({
    required this.id,
    required this.name,
    this.isFolder = false,
    this.xmlContent = '',
    this.codeContent = '',
    this.parentId,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isFolder': isFolder,
      'xmlContent': xmlContent,
      'codeContent': codeContent,
      'parentId': parentId,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ProjectFile.fromJson(Map<String, dynamic> json) {
    return ProjectFile(
      id: json['id'],
      name: json['name'],
      isFolder: json['isFolder'] ?? false,
      xmlContent: json['xmlContent'] ?? '',
      codeContent: json['codeContent'] ?? '',
      parentId: json['parentId'],
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  ProjectFile copyWith({
    String? name,
    String? xmlContent,
    String? codeContent,
    String? parentId,
    DateTime? updatedAt,
  }) {
    return ProjectFile(
      id: id,
      name: name ?? this.name,
      isFolder: isFolder,
      xmlContent: xmlContent ?? this.xmlContent,
      codeContent: codeContent ?? this.codeContent,
      parentId: parentId ?? this.parentId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Project {
  final String id;
  String name;
  List<ProjectFile> files;
  DateTime updatedAt;
  DateTime createdAt;

  Project({
    required this.id,
    required this.name,
    List<ProjectFile>? files,
    DateTime? updatedAt,
    DateTime? createdAt,
  })  : files = files ?? [],
        updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'files': files.map((f) => f.toJson()).toList(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory Project.fromJson(Map<String, dynamic> json) {
    // Muqobil ravishda eski loyihalarni ishga tushirish uchun "xmlContent" ni tekshirish
    List<ProjectFile> parsedFiles = [];
    if (json['files'] != null) {
      parsedFiles = (json['files'] as List).map((e) => ProjectFile.fromJson(e)).toList();
    } else if (json['xmlContent'] != null) {
      // Legacy loyiha uchun index.html yaratish
      parsedFiles.add(ProjectFile(
        id: 'legacy_index_html',
        name: 'index.html',
        xmlContent: json['xmlContent'],
      ));
    }

    return Project(
      id: json['id'],
      name: json['name'],
      files: parsedFiles,
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Project copyWith({
    String? name,
    List<ProjectFile>? files,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id,
      name: name ?? this.name,
      files: files ?? this.files,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt,
    );
  }
}

