import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';
import '../utils/html_editor.dart';
import '../data/blockly_html_template.dart';
import '../data/html_blocks_config.dart';

class EditorPage extends StatefulWidget {
  final Project project;
  final ProjectFile file;

  const EditorPage({super.key, required this.project, required this.file});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late ProjectFile _file;
  late Project _project;
  String _generatedHtml = '';
  String _mode = 'html';
  
  late WebViewController _blocklyController;
  late WebViewController _aceController;
  late WebViewController _previewController;
  
  bool _isSaving = false;
  bool _isReady = false;
  bool _isSupported = true;
  bool _isAceLoaded = false;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
    _file = widget.file;
    
    final name = _file.name.toLowerCase();
    _isSupported = name.endsWith('.html') || name.endsWith('.css') || name.endsWith('.js');
    
    if (_isSupported) {
      _generatedHtml = _file.codeContent;
      _tabController = TabController(length: name.endsWith('.html') ? 3 : 2, vsync: this);
      _initControllers();
    } else {
      _isReady = true;
    }
  }

  Future<void> _initControllers() async {
    Map<String, dynamic> toolbox;
    String mode = 'html';

    if (_file.name.endsWith('.css')) {
      toolbox = cssToolboxConfig;
      mode = 'css';
    } else if (_file.name.endsWith('.js')) {
      toolbox = jsToolboxConfig;
      mode = 'javascript';
    } else {
      toolbox = htmlToolboxConfig;
      mode = 'html';
    }

    _mode = mode;
    final aceHtml = await getAceEditorTemplate();
    final blocklyHtml = await getBlocklyHtmlTemplate(toolbox);

    _blocklyController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel('WebBlocksApp', onMessageReceived: _handleAppMessage)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          final safeXml = _file.xmlContent.isNotEmpty 
              ? _file.xmlContent.replaceAll(r'\', r'\\').replaceAll('"', r'\"').replaceAll('\n', r'\n').replaceAll('\r', '')
              : initialPageXml.replaceAll(r'\', r'\\').replaceAll('"', r'\"').replaceAll('\n', r'\n').replaceAll('\r', '');
          _blocklyController.runJavaScript('if(typeof initBlockly === "function") initBlockly("$safeXml");');
        },
      ))
      ..loadHtmlString(blocklyHtml);

    _aceController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF2B2B2B))
      ..addJavaScriptChannel('WebBlocksApp', onMessageReceived: _handleAppMessage)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          setState(() => _isAceLoaded = true);
          _updateAceCode();
        },
      ))
      ..loadHtmlString(aceHtml);

    if (_file.name.endsWith('.html')) {
      _previewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white);
    }

    _tabController.addListener(() {
      if (mounted) setState(() {});
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 1) _updateAceCode();
        if (_tabController.index == 2 && _file.name.endsWith('.html')) _updatePreview();
      }
    });

    if (mounted) {
      setState(() => _isReady = true);
    }
  }

  void _updateAceCode() {
    if (!_isAceLoaded) return;
    final safeCode = _generatedHtml
        .replaceAll(r'\', r'\\')
        .replaceAll('"', r'\"')
        .replaceAll('\n', r'\n')
        .replaceAll('\r', '');
    // JS-dagi setCode funksiyasi ichida getValue tekshiruvi bor, cursor sakrab ketmasligi uchun.
    _aceController.runJavaScript('if(typeof setCode === "function") setCode("$safeCode", "$_mode");');
  }

  void _updatePreview() {
    if (!_file.name.endsWith('.html')) return;
    _previewController.loadHtmlString(_generatedHtml);
  }

  void _handleAppMessage(JavaScriptMessage message) {
    try {
      final data = jsonDecode(message.message) as Map<String, dynamic>;
      
      // Handle manual code changes from Ace
      if (data['type'] == 'code_change') {
        final String newCode = data['code'] ?? '';
        if (mounted) {
          setState(() {
            _file = _file.copyWith(codeContent: newCode, updatedAt: DateTime.now());
            _generatedHtml = newCode;
          });
          _autoSave();
          // Faqat previewni yangilaymiz agar html bo'lsa
          if (_tabController.index == 2) _updatePreview();
        }
        return;
      }

      if (data['type'] == 'error') return;

      final String xml = data['xml'] ?? '';
      final String html = data['html'] ?? '';

      if (mounted) {
        final formattedHtml = formatHtmlCode(html);
        setState(() {
          _file = _file.copyWith(xmlContent: xml, codeContent: formattedHtml, updatedAt: DateTime.now());
          _generatedHtml = formattedHtml;
        });
        
        // HAR QANDAY O'ZGARISHDA AVTOMATIK SAQLASH
        _autoSave();
        
        // Faqat Blockly tabida bo'lsak Ace dagi kodni yangilaymiz
        if (_tabController.index == 0) {
          _updateAceCode();
        }
        
        if (_tabController.index == 2) _updatePreview();
      }
    } catch (e) {}
  }

  Future<void> _autoSave() async {
    final idx = _project.files.indexWhere((f) => f.id == _file.id);
    if (idx != -1) {
       _project.files[idx] = _file;
       await ProjectService().saveProject(_project);
    }
  }

  Future<void> _saveFile() async {
    if (!_isSupported) return;
    setState(() => _isSaving = true);
    await _autoSave();
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saqlandi!'), duration: Duration(milliseconds: 500)));
    }
  }

  @override
  void dispose() {
    if (_isSupported) _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSupported) {
      return Scaffold(
        appBar: AppBar(title: Text(_file.name)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              Text('Bu fayl turi qo\'llab-quvvatlanmaydi', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Faqat .html, .css va .js fayllarini tahrirlash mumkin.', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Orqaga qaytish')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5F6368)),
          onPressed: () async {
            await _saveFile();
            if (context.mounted) Navigator.pop(context, _file);
          },
        ),
        title: Text('${_project.name} / ${_file.name}', style: GoogleFonts.inter(color: const Color(0xFF202124), fontSize: 14, fontWeight: FontWeight.w500)),
        actions: [
          if (_isReady && _tabController.index == 0) ...[
            IconButton(
              icon: const Icon(Icons.undo, color: Color(0xFF1A73E8)),
              tooltip: 'Undo',
              onPressed: () => _blocklyController.runJavaScript('if(workspace) workspace.undo(false);'),
            ),
            IconButton(
              icon: const Icon(Icons.redo, color: Color(0xFF1A73E8)),
              tooltip: 'Redo',
              onPressed: () => _blocklyController.runJavaScript('if(workspace) workspace.undo(true);'),
            ),
          ],
          if (_isReady && _tabController.index == 1) ...[
            IconButton(
              icon: const Icon(Icons.cleaning_services_rounded, color: Color(0xFF1A73E8)),
              tooltip: 'Kodni tozalash',
              onPressed: () => _aceController.runJavaScript('if(typeof formatCode === "function") formatCode();'),
            ),
          ],
          IconButton(icon: _isSaving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check_rounded, color: Color(0xFF1A73E8)), onPressed: _saveFile),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF1A73E8),
              labelColor: const Color(0xFF1A73E8),
              unselectedLabelColor: const Color(0xFF5F6368),
              tabs: [
                const Tab(text: 'Bloklar'),
                const Tab(text: 'Kod'),
                if (_file.name.endsWith('.html')) const Tab(text: 'Natija'),
              ],
            ),
          ),
        ),
      ),
      body: !_isReady 
        ? const Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _KeepAliveWrapper(child: WebViewWidget(controller: _blocklyController)),
              _KeepAliveWrapper(child: WebViewWidget(controller: _aceController)),
              if (_file.name.endsWith('.html')) _KeepAliveWrapper(child: WebViewWidget(controller: _previewController)),
            ],
          ),
    );
  }
}

class _KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const _KeepAliveWrapper({required this.child});
  @override
  State<_KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<_KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
