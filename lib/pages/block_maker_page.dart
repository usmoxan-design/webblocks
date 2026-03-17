import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlockMakerPage extends StatefulWidget {
  const BlockMakerPage({super.key});

  @override
  State<BlockMakerPage> createState() => _BlockMakerPageState();
}

class _BlockMakerPageState extends State<BlockMakerPage> {
  final _typeController = TextEditingController(text: 'custom_block');
  final _messageController = TextEditingController(text: 'block %1 %2');
  final _colorController = TextEditingController(text: '#1A73E8');
  
  bool _hasPrevious = true;
  bool _hasNext = true;
  String? _outputType; // null, 'Attribute', 'Boolean'
  String _generatorType = 'HTML';

  List<Map<String, dynamic>> _args = [
    {'type': 'input_value', 'name': 'ATTR', 'check': 'Attribute'},
    {'type': 'input_statement', 'name': 'CONTENT', 'check': ''},
  ];

  late WebViewController _previewController;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    final html = await _getBlockMakerTemplate();
    _previewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          _updatePreview();
        },
      ))
      ..loadHtmlString(html);
    
    if (mounted) setState(() => _isReady = true);
  }

  void _updatePreview() {
    final jsonDef = _generateJsonDefinition();
    _previewController.runJavaScript('updateBlockDefinition($jsonDef);');
  }

  String _generateJsonDefinition() {
    final List<Map<String, dynamic>> args0 = _args.map((e) {
      final Map<String, dynamic> map = {'type': e['type']};
      
      if (e['type'] != 'input_dummy') {
        map['name'] = e['name'] ?? 'NAME';
      }

      if (e['type'] == 'input_value') {
        map['check'] = (e['check'] == null || e['check']!.isEmpty) ? 'Attribute' : e['check'];
      } else if (e['type'] == 'field_input') {
        map['text'] = e['text'] ?? '';
      } else if (e['type'] == 'field_dropdown') {
        try {
          map['options'] = jsonDecode(e['options'] ?? '[["Option", "VAL"]]');
        } catch (err) {
          map['options'] = [["Xato!", "ERROR"]];
        }
      }
      return map;
    }).toList();

    final Map<String, dynamic> def = {
      'type': _typeController.text,
      'message0': _messageController.text,
      'args0': args0,
      'colour': _colorController.text,
    };

    if (_outputType != null && _outputType != 'none') {
      def['output'] = _outputType;
    } else {
      if (_hasPrevious) def['previousStatement'] = null;
      if (_hasNext) def['nextStatement'] = null;
    }

    return const JsonEncoder.withIndent('  ').convert(def);
  }

  String _generateGeneratorCode() {
    final type = _typeController.text;
    final isOutput = _outputType != null && _outputType != 'none';
    
    String code = "case '$type': {\n";

    // 1. Argument o'zgaruvchilarini aniqlash
    for (var arg in _args) {
      String name = arg['name'] ?? '';
      String varName = name.toLowerCase();
      if (arg['type'] == 'input_statement') {
        code += "  var $varName = statementToHtml(block, '$name');\n";
      } else if (arg['type'] == 'field_input' || arg['type'] == 'field_dropdown') {
        code += "  var $varName = block.getFieldValue('$name');\n";
      } else if (arg['type'] == 'input_value') {
        code += "  var $varName = valueToHtml(block, '$name');\n";
      }
    }

    // 2. Message0 dan kod shablonini yasash
    String msg = _messageController.text;
    // Tirnoqlarni to'g'irlash
    msg = msg.replaceAll("'", "\\'");

    // %1, %2 kabi joylarni o'zgaruvchilar bilan almashtirish
    String resultKod = msg;
    for (int i = 0; i < _args.length; i++) {
      String varName = (_args[i]['name'] ?? 'arg${i+1}').toLowerCase();
      resultKod = resultKod.replaceAll('%${i + 1}', "' + $varName + '");
    }

    // Ortiqcha string ulanishlarini tozalash
    resultKod = resultKod.replaceAll("'' + ", "").replaceAll(" + ''", "");

    if (isOutput) {
      code += "  return '$resultKod';\n";
    } else {
      code += "  out = '$resultKod\\n';\n";
    }

    code += "  break;\n}";
    return code;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Block Maker', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF202124),
        actions: [
          DropdownButton<String>(
            value: _generatorType,
            underline: Container(),
            items: ['HTML', 'JS', 'CSS'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _generatorType = val!),
          ),
          const SizedBox(width: 16),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
        backgroundColor: const Color(0xFF1A73E8),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.9,
        backgroundColor: const Color(0xFFF8F9FA),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.build_circle, size: 36, color: Color(0xFF1A73E8)),
                    const SizedBox(height: 8),
                    Text('Blok Sozlamalari', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Asosiy sozlamalar'),
                    _buildTextField('Blok turi (ID)', _typeController),
                    _buildTextField('Xabar (masalan: <b> %1 </b>)', _messageController),
                    
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Rang (Hex)', _colorController)),
                        const SizedBox(width: 10),
                        Container(
                          width: 45,
                          height: 45,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Color(int.parse(_colorController.text.replaceFirst('#', '0xFF'))),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                        ),
                      ],
                    ),

                    _buildSectionTitle('Blok turi va ulanishlari'),
                    DropdownButtonFormField<String>(
                      value: _outputType ?? 'none',
                      decoration: const InputDecoration(labelText: 'Output turi', border: OutlineInputBorder()),
                      items: const [
                        DropdownMenuItem(value: 'none', child: Text('Ulanishli blok (Statement)')),
                        DropdownMenuItem(value: 'Attribute', child: Text('Qiymat: Attribute')),
                        DropdownMenuItem(value: 'Boolean', child: Text('Qiymat: Boolean')),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _outputType = (val == 'none') ? null : val;
                        });
                        _updatePreview();
                      },
                    ),
                    
                    if (_outputType == null || _outputType == 'none') ...[
                      const SizedBox(height: 10),
                      SwitchListTile(
                        title: const Text('Previous Connection'),
                        value: _hasPrevious,
                        onChanged: (val) => setState(() { _hasPrevious = val; _updatePreview(); }),
                      ),
                      SwitchListTile(
                        title: const Text('Next Connection'),
                        value: _hasNext,
                        onChanged: (val) => setState(() { _hasNext = val; _updatePreview(); }),
                      ),
                    ],

                    const SizedBox(height: 20),
                    _buildSectionTitle('Argumentlar'),
                    ..._args.asMap().entries.map((entry) => _buildArgItem(entry.key, entry.value)),
                    
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _args.add({'type': 'input_value', 'name': 'NEW_ARG', 'check': ''});
                        });
                        _updatePreview();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Argument qo\'shish'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildSectionTitle('Generatsiya qilingan kod'),
                    _buildCodeDisplay('JSON Definition', _generateJsonDefinition()),
                    const SizedBox(height: 10),
                    _buildCodeDisplay('JS Generator (Avtomatik)', _generateGeneratorCode()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFF8F9FA),
            child: Row(
              children: [
                const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF5F6368)),
                const SizedBox(width: 8),
                Text('Jonli ko\'rinish', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF5F6368))),
              ],
            ),
          ),
          Expanded(
            child: !_isReady 
              ? const Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: _previewController),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Text(title.toUpperCase(), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF5F6368), letterSpacing: 1.2)),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        onChanged: (_) {
          setState(() {});
          _updatePreview();
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFDADCE0))),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildArgItem(int index, Map<String, dynamic> arg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDADCE0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: arg['type'],
                  decoration: const InputDecoration(labelText: 'Turi', border: InputBorder.none),
                  items: const [
                    DropdownMenuItem(value: 'input_value', child: Text('Qiymat (Value)')),
                    DropdownMenuItem(value: 'input_statement', child: Text('Blok ichi (Statement)')),
                    DropdownMenuItem(value: 'input_dummy', child: Text('Bo\'sh joy (Dummy)')),
                    DropdownMenuItem(value: 'field_input', child: Text('Matn (Field Input)')),
                    DropdownMenuItem(value: 'field_dropdown', child: Text('Tanlov (Dropdown)')),
                  ],
                  onChanged: (val) {
                    setState(() => _args[index]['type'] = val!);
                    _updatePreview();
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  setState(() => _args.removeAt(index));
                  _updatePreview();
                },
              ),
            ],
          ),
          if (arg['type'] != 'input_dummy')
            TextFormField(
              initialValue: arg['name'],
              decoration: const InputDecoration(labelText: 'Nomi (name)', isDense: true),
              onChanged: (val) {
                setState(() => _args[index]['name'] = val);
                _updatePreview();
              },
            ),
          const SizedBox(height: 8),
          if (arg['type'] == 'input_value')
            TextFormField(
              initialValue: arg['check'],
              decoration: const InputDecoration(labelText: 'Check (Attribute/Boolean)', isDense: true),
              onChanged: (val) {
                setState(() => _args[index]['check'] = val);
                _updatePreview();
              },
            ),
          if (arg['type'] == 'field_input')
            TextFormField(
              initialValue: arg['text'],
              decoration: const InputDecoration(labelText: 'Default Text', isDense: true),
              onChanged: (val) {
                setState(() => _args[index]['text'] = val);
                _updatePreview();
              },
            ),
          if (arg['type'] == 'field_dropdown')
            TextFormField(
              initialValue: arg['options'] ?? '[["Option", "VAL"]]',
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Options (JSON Format)', hintText: '[["Label", "Value"]]', isDense: true),
              onChanged: (val) {
                setState(() => _args[index]['options'] = val);
                _updatePreview();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCodeDisplay(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2B2B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectableText(
            code,
            style: const TextStyle(color: Color(0xFFF8F9FA), fontFamily: 'monospace', fontSize: 11),
          ),
        ),
      ],
    );
  }

  Future<String> _getBlockMakerTemplate() async {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/blockly_compressed.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/blocks_compressed.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/msg/en.js"></script>
  <style>
    body, html { margin: 0; padding: 0; width: 100%; height: 100%; overflow: hidden; background-color: #FFFFFF; }
    #blocklyDiv { width: 100%; height: 100%; }
  </style>
</head>
<body>
  <div id="blocklyDiv"></div>
  <script>
    var workspace = Blockly.inject('blocklyDiv', {
      readOnly: false,
      scrollbars: false,
      trashcan: false,
      renderer: 'zelos'
    });

    function updateBlockDefinition(jsonDef) {
       try {
         Blockly.Blocks[jsonDef.type] = null;
         Blockly.defineBlocksWithJsonArray([jsonDef]);
         workspace.clear();
         var block = workspace.newBlock(jsonDef.type);
         block.initSvg();
         block.render();
         block.moveBy(20, 20);
       } catch(e) { console.error(e); }
    }
  </script>
</body>
</html>
''';
  }
}
