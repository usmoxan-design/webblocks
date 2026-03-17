import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBlock {
  final String id;
  final String type;
  final String jsonDefinition;
  final String generatorCode;
  final String category;
  final String generatorType; // 'HTML', 'CSS', 'JS'

  CustomBlock({
    required this.id,
    required this.type,
    required this.jsonDefinition,
    required this.generatorCode,
    required this.category,
    required this.generatorType,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'jsonDefinition': jsonDefinition,
        'generatorCode': generatorCode,
        'category': category,
        'generatorType': generatorType,
      };

  factory CustomBlock.fromJson(Map<String, dynamic> json) => CustomBlock(
        id: json['id'],
        type: json['type'],
        jsonDefinition: json['jsonDefinition'],
        generatorCode: json['generatorCode'],
        category: json['category'] ?? 'Custom',
        generatorType: json['generatorType'] ?? 'HTML',
      );
}

class CustomBlockService {
  static const String _key = 'custom_blocks';

  Future<List<CustomBlock>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => CustomBlock.fromJson(e)).toList();
  }

  Future<void> save(CustomBlock block) async {
    final blocks = await getAll();
    final idx = blocks.indexWhere((b) => b.type == block.type);
    if (idx != -1) {
      blocks[idx] = block;
    } else {
      blocks.add(block);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(blocks.map((b) => b.toJson()).toList()));
  }

  Future<void> delete(String type) async {
    final blocks = await getAll();
    blocks.removeWhere((b) => b.type == type);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(blocks.map((b) => b.toJson()).toList()));
  }

  /// Barcha custom bloklarni Blockly uchun JSON Definition string sifatida qaytaradi
  Future<String> getCombinedDefinitions() async {
    final blocks = await getAll();
    if (blocks.isEmpty) return '';
    final defs = blocks.map((b) => b.jsonDefinition).join(',\n');
    return 'Blockly.defineBlocksWithJsonArray([$defs]);';
  }

  /// Barcha custom bloklarning generator switch-case kodini qaytaradi
  Future<String> getCombinedGenerators() async {
    final blocks = await getAll();
    if (blocks.isEmpty) return '';
    return blocks.map((b) => b.generatorCode).join('\n');
  }

  /// Toolbox uchun custom kategoriyalar ro'yxatini qaytaradi (generatorType bo'yicha)
  Future<Map<String, dynamic>?> getCustomCategory(String genType) async {
    final blocks = await getAll().then((list) => list.where((b) => b.generatorType == genType).toList());
    if (blocks.isEmpty) return null;

    // Kategoriyalar bo'yicha guruhlash
    final Map<String, List<Map<String, dynamic>>> byCategory = {};
    for (final b in blocks) {
      byCategory.putIfAbsent(b.category, () => []);
      byCategory[b.category]!.add({'kind': 'block', 'type': b.type});
    }

    return {
      'kind': 'category',
      'name': 'Mening Bloklarim',
      'colour': '#673AB7',
      'contents': byCategory.entries.map((e) => {
        'kind': 'category',
        'name': e.key,
        'colour': '#9C27B0',
        'contents': e.value,
      }).toList(),
    };
  }
}
