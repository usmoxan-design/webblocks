import 'dart:convert';
import 'html_blocks_config.dart';

Future<String> getBlocklyHtmlTemplate(Map<String, dynamic> toolboxConfig) async {
  return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
  <title>Blockly Editor</title>
  
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/blockly_compressed.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/blocks_compressed.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/javascript_compressed.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/blockly@10.2.2/msg/en.js"></script>
  
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #FFFFFF;
      font-family: sans-serif;
      overflow: hidden;
    }
    #blocklyDiv {
      height: 100vh;
      width: 100vw;
    }
    .blocklyToolboxDiv {
      background-color: #F8F9FA !important;
      border-right: 1px solid #E0E0E0 !important;
      z-index: 100 !important;
    }
    
    /* Custom Prompt Dialog */
    #customPrompt {
      display: none;
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 1000;
      justify-content: center;
      align-items: center;
    }
    .prompt-content {
      background: white;
      padding: 20px;
      border-radius: 12px;
      width: 80%;
      max-width: 400px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
    }
    .prompt-content h3 { margin-top: 0; font-size: 16px; color: #1A73E8; }
    .prompt-content textarea {
      width: 100%;
      height: 120px;
      margin: 10px 0;
      padding: 8px;
      border: 1px solid #DADCE0;
      border-radius: 4px;
      font-family: monospace;
      font-size: 14px;
      box-sizing: border-box;
    }
    .prompt-actions { text-align: right; }
    .prompt-actions button {
      padding: 8px 16px;
      margin-left: 8px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
    }
    .btn-cancel { background: #F1F3F4; color: #5F6368; }
    .btn-ok { background: #1A73E8; color: white; }
  </style>
</head>
<body>

  <div id="blocklyDiv"></div>

  <div id="customPrompt">
    <div class="prompt-content">
      <h3 id="promptTitle">Qiymatni o'zgartirish</h3>
      <textarea id="promptInput"></textarea>
      <div class="prompt-actions">
        <button class="btn-cancel" onclick="closePrompt(false)">Bekor qilish</button>
        <button class="btn-ok" onclick="closePrompt(true)">Saqlash</button>
      </div>
    </div>
  </div>

  <script>
    var workspace = null;
    var currentPromptCallback = null;

    function closePrompt(isOk) {
      var val = document.getElementById('promptInput').value;
      document.getElementById('customPrompt').style.display = 'none';
      if (currentPromptCallback) {
        currentPromptCallback(isOk ? val : null);
        currentPromptCallback = null;
      }
    }

    function initBlockly(xmlStr) {
      if (workspace) return;
      
      try {
        if (typeof Blockly === 'undefined') {
          throw new Error('Blockly kutubxonasi yuklanmadi. Internet aloqasini tekshiring.');
        }

        // Bloklar va generatorlarni yuklash
        $combinedBlockDefinitions

        // ----------------------------------------------------
        // MAXSUS: Long Press orqali blok drag (document-da inject dan OLDIN)
        // document-level capture, Blockly'dan OLDIN ishlaydi
        // ----------------------------------------------------
        (function() {
          var touchStartX, touchStartY;
          var longPressReady = false;
          var longPressTimer = null;
          var isTouchOnBlock = false;
          var scrollStartX, scrollStartY;

          // document da capture: Blockly ning inject qilingan elementidan oldin
          document.addEventListener('touchstart', function(e) {
            var target = e.target;
            isTouchOnBlock = !!(
              target.closest && (
                target.closest('.blocklyDraggable') ||
                target.closest('.blocklyBlockCanvas')
              )
            );

            if (!isTouchOnBlock) return;

            touchStartX = e.touches[0].clientX;
            touchStartY = e.touches[0].clientY;
            scrollStartX = touchStartX;
            scrollStartY = touchStartY;
            longPressReady = false;

            clearTimeout(longPressTimer);
            longPressTimer = setTimeout(function() {
              longPressReady = true;
            }, 300);

            // Blockly ga yetib bormasin — biz boshqaramiz
            e.stopImmediatePropagation();
            e.preventDefault();
          }, { capture: true, passive: false });

          document.addEventListener('touchmove', function(e) {
            if (!isTouchOnBlock) return;

            var curX = e.touches[0].clientX;
            var curY = e.touches[0].clientY;
            var dx = curX - touchStartX;
            var dy = curY - touchStartY;
            var dist = Math.sqrt(dx * dx + dy * dy);

            if (longPressReady) {
              // 300ms o'tdi, endi Blockly blokni drag qilsin
              // Bu eventni to'g'ridan Blockly ga o'tkazamiz
              return;
            }

            // Hali 300ms bo'lmadi
            if (dist > 8) {
              clearTimeout(longPressTimer);
              longPressReady = false;
              isTouchOnBlock = false; // bundan keyin block sifatida qarashni to'xtatamiz

              // Workspace ni qo'lda scroll qilamiz
              if (workspace) {
                var sdx = curX - scrollStartX;
                var sdy = curY - scrollStartY;
                workspace.scroll(workspace.scrollX - sdx, workspace.scrollY - sdy);
              }
              scrollStartX = curX;
              scrollStartY = curY;
            }
            // Hozircha Blockly ga yetkazmaymiz
            e.stopImmediatePropagation();
            e.preventDefault();
          }, { capture: true, passive: false });

          document.addEventListener('touchend', function(e) {
            clearTimeout(longPressTimer);
            longPressTimer = null;
            if (!longPressReady) isTouchOnBlock = false;
            longPressReady = false;
          }, { capture: true });
        })();
        // ----------------------------------------------------

        // Custom prompt override
        Blockly.dialog.setPrompt(function(message, defaultValue, callback) {
          document.getElementById('promptTitle').innerText = message;
          document.getElementById('promptInput').value = defaultValue;
          document.getElementById('customPrompt').style.display = 'flex';
          currentPromptCallback = callback;
        });

        var toolboxConfig = ${jsonEncode(toolboxConfig)};

        workspace = Blockly.inject('blocklyDiv', {
          toolbox: toolboxConfig,
          grid: { spacing: 20, length: 3, colour: '#E8EAED', snap: true },
          zoom: { controls: true, wheel: true, startScale: 0.65, maxScale: 3, minScale: 0.3, scaleSpeed: 1.2 },
          move: { scrollbars: { horizontal: true, vertical: true }, drag: true, wheel: true },
          trashcan: true,
          renderer: 'zelos'
        });

        if (!workspace) throw new Error('Blockly xatosi: Workspace yaratilmadi.');

        if (xmlStr) {
          try {
            var dom = Blockly.utils.xml.textToDom(xmlStr);
            Blockly.Xml.domToWorkspace(dom, workspace);
          } catch (e) { console.error('Error loading XML:', e); }
        }

        workspace.addChangeListener(function(event) {
          if (event.type != Blockly.Events.UI) {
            try {
              var xml = Blockly.Xml.workspaceToDom(workspace);
              var xmlText = Blockly.Xml.domToText(xml);
              var htmlCode = generateHtml(workspace);
              
              if (window.WebBlocksApp) {
                window.WebBlocksApp.postMessage(JSON.stringify({
                  xml: xmlText,
                  html: htmlCode
                }));
              }
            } catch(e) {}
          }
        });
        
        window.addEventListener('resize', function() {
           Blockly.svgResize(workspace);
        }, false);
        Blockly.svgResize(workspace);

      } catch (err) {
        console.error('initBlockly error:', err);
        if (window.WebBlocksApp) {
          window.WebBlocksApp.postMessage(JSON.stringify({ 
            type: 'error', 
            msg: err.message 
          }));
        }
      }
    }

    function toggleToolbox(isOpen) {
      if (isOpen) {
        document.body.classList.remove('toolbox-hidden');
      } else {
        document.body.classList.add('toolbox-hidden');
        if (workspace) workspace.getFlyout().hide();
      }
      if (workspace) Blockly.svgResize(workspace);
    }
    
    // HTML dan XML yasash va Workspace ga yozish (Ikki tomonlama sinxron)
    function importHtml(htmlStr) {
      if (!workspace) return false;
      var parser = new DOMParser();
      var doc = parser.parseFromString(htmlStr, 'text/html');
      var parserError = doc.querySelector('parsererror');
      if (parserError) throw new Error('HTML syntax error');
      
      var rootXml = '<xml xmlns="https://developers.google.com/blockly/xml">';
      rootXml += nodeToBlockXml(doc.documentElement, 20, 20);
      rootXml += '</xml>';
      
      try {
        var dom = Blockly.utils.xml.textToDom(rootXml);
        workspace.clear();
        Blockly.Xml.domToWorkspace(dom, workspace);
        return true;
      } catch(e) {
        throw e;
      }
    }

    function nodeToBlockXml(node, x, y) {
      if (!node) return '';
      var out = '';
      
      if (node.nodeType === 3) { // Text node
        var txt = node.textContent.trim();
        if (!txt) return node.nextSibling ? nodeToBlockXml(node.nextSibling) : '';
        out += '<block type="html_text_node" ' + (x !== undefined ? 'x="'+x+'" y="'+y+'"' : '') + '>';
        out += '<field name="TEXT">' + escapeXml(txt) + '</field>';
        if (node.nextSibling) {
          var nXml = nodeToBlockXml(node.nextSibling);
          if (nXml) out += '<next>' + nXml + '</next>';
        }
        out += '</block>';
        return out;
      }
      
      if (node.nodeType === 1) { // Element node
        var tag = node.tagName.toLowerCase();
        var map = {
          'html':'html_document', 'head':'html_head', 'body':'html_body', 'title':'html_title',
          'div':'html_div', 'section':'html_section', 'span':'html_span', 'h1':'html_h1', 'p':'html_p',
          'ul':'html_ul', 'li':'html_li', 'a':'html_a', 'img':'html_img', 'script':'html_script'
        };
        var bType = map[tag];
        
        if (!bType) {
          var childrenXml = '';
          if (node.firstChild) childrenXml = nodeToBlockXml(node.firstChild);
          if (node.nextSibling) {
            var nXml = nodeToBlockXml(node.nextSibling);
            if (nXml) childrenXml += (childrenXml?'<next>':'') + nXml + (childrenXml?'</next>':'');
          }
          return childrenXml;
        }
        
        out += '<block type="' + bType + '" ' + (x !== undefined ? 'x="'+x+'" y="'+y+'"' : '') + '>';
        
        if (node.attributes && node.attributes.length > 0) {
          out += '<value name="ATTR">';
          out += attrsToBlockXml(node.attributes, 0);
          out += '</value>';
        }
        
        if (bType === 'html_text_node') { } 
        else if (bType === 'html_span') {
          if (node.firstChild) {
             out += '<value name="CONTENT">';
             out += nodeToBlockXml(node.firstChild);
             out += '</value>';
          }
        }
        else if (bType === 'html_title' || bType === 'html_h1') {
          out += '<field name="' + (bType==='html_title'?'TITLE':'TEXT') + '">' + escapeXml(node.textContent) + '</field>';
        }
        else if (bType === 'html_img' || bType === 'html_script') {
            if (bType === 'html_script' && node.firstChild) {
                out += '<statement name="CONTENT">';
                out += nodeToBlockXml(node.firstChild);
                out += '</statement>';
            }
        }
        else {
          if (node.firstChild) {
            var contentXml = nodeToBlockXml(node.firstChild);
            if (contentXml) {
              out += '<statement name="CONTENT">' + contentXml + '</statement>';
            }
          }
        }
        
        if (node.nextSibling) {
          var nextXml = nodeToBlockXml(node.nextSibling);
          if (nextXml) out += '<next>' + nextXml + '</next>';
        }
        out += '</block>';
        return out;
      }
      return node.nextSibling ? nodeToBlockXml(node.nextSibling) : '';
    }

    function attrsToBlockXml(attrs, index) {
      if (index >= attrs.length) return '';
      var attr = attrs[index];
      var supported = ['class', 'id', 'style', 'src', 'href', 'alt', 'type', 'placeholder', 'name'];
      var isSupported = supported.indexOf(attr.name.toLowerCase()) !== -1;
      var bType = isSupported ? 'html_attribute' : 'html_custom_attribute';
      
      var out = '<block type="' + bType + '">';
      out += '<field name="ATTR_NAME">' + escapeXml(attr.name) + '</field>';
      out += '<field name="ATTR_VALUE">' + escapeXml(attr.value) + '</field>';
      
      var nextAttr = attrsToBlockXml(attrs, index + 1);
      if (nextAttr) {
        out += '<value name="NEXT">' + nextAttr + '</value>';
      }
      out += '</block>';
      return out;
    }

    function escapeXml(unsafe) {
      if (!unsafe) return '';
      return unsafe.replace(/[<>&'"]/g, function(c){
        switch(c){
          case '<': return '&lt;'; case '>': return '&gt;';
          case '&': return '&amp;'; case '\\'': return '&apos;'; case '"': return '&quot;';
        }
      });
    }
  </script>
</body>
</html>
  ''';
}

// String htmlToolboxConfigJson() {
//   // Dartdagi Mapni JSON formatida qaytaramiz (String kabi, qo'lda o'girgan ma'qul, lekin import 'dart:convert' bilan qilsak qulay
//   // Biz `html_blocks_config.dart` ichidagi oddiy Mapdan foydalanamiz
//   return '''
//   {
//   "kind": "categoryToolbox",
//   "contents": [
//     {
//       "kind": "category", "name": "Page", "colour": "#F5A623",
//       "contents": [
//         {"kind": "block", "type": "html_document"},
//         {"kind": "block", "type": "html_head"},
//         {"kind": "block", "type": "html_body"},
//         {"kind": "block", "type": "html_title"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Structure", "colour": "#E8732A",
//       "contents": [
//         {"kind": "block", "type": "html_div"},
//         {"kind": "block", "type": "html_section"},
//         {"kind": "block", "type": "html_article"},
//         {"kind": "block", "type": "html_nav"},
//         {"kind": "block", "type": "html_header"},
//         {"kind": "block", "type": "html_footer"},
//         {"kind": "block", "type": "html_main"},
//         {"kind": "block", "type": "html_span"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Text", "colour": "#4285F4",
//       "contents": [
//         {"kind": "block", "type": "html_h1"},
//         {"kind": "block", "type": "html_h2"},
//         {"kind": "block", "type": "html_h3"},
//         {"kind": "block", "type": "html_p"},
//         {"kind": "block", "type": "html_strong"},
//         {"kind": "block", "type": "html_em"},
//         {"kind": "block", "type": "html_br"},
//         {"kind": "block", "type": "html_hr"},
//         {"kind": "block", "type": "html_text_node"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Attributes", "colour": "#34A853",
//       "contents": [
//         {"kind": "block", "type": "html_attribute"},
//         {"kind": "block", "type": "html_custom_attribute"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Style", "colour": "#9B59B6",
//       "contents": [
//         {"kind": "block", "type": "html_style_block"},
//         {"kind": "block", "type": "html_inline_style"},
//         {"kind": "block", "type": "html_css_rule"},
//         {"kind": "block", "type": "html_css_color"},
//         {"kind": "block", "type": "html_css_bg_color"},
//         {"kind": "block", "type": "html_css_font_size"},
//         {"kind": "block", "type": "html_css_padding"},
//         {"kind": "block", "type": "html_css_margin"},
//         {"kind": "block", "type": "html_css_text_align"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Media", "colour": "#E74C3C",
//       "contents": [
//         {"kind": "block", "type": "html_img"},
//         {"kind": "block", "type": "html_video"},
//         {"kind": "block", "type": "html_audio"},
//         {"kind": "block", "type": "html_iframe"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Links", "colour": "#1ABC9C",
//       "contents": [
//         {"kind": "block", "type": "html_a"},
//         {"kind": "block", "type": "html_button"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Forms", "colour": "#3498DB",
//       "contents": [
//         {"kind": "block", "type": "html_form"},
//         {"kind": "block", "type": "html_input"},
//         {"kind": "block", "type": "html_label"},
//         {"kind": "block", "type": "html_textarea"},
//         {"kind": "block", "type": "html_select"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Tables", "colour": "#E67E22",
//       "contents": [
//         {"kind": "block", "type": "html_table"},
//         {"kind": "block", "type": "html_tr"},
//         {"kind": "block", "type": "html_td"},
//         {"kind": "block", "type": "html_th"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Lists", "colour": "#27AE60",
//       "contents": [
//         {"kind": "block", "type": "html_ul"},
//         {"kind": "block", "type": "html_ol"},
//         {"kind": "block", "type": "html_li"}
//       ]
//     },
//     {
//       "kind": "category", "name": "Script", "colour": "#E74C3C",
//       "contents": [
//         {"kind": "block", "type": "html_script"},
//         {"kind": "block", "type": "html_link_css"},
//         {"kind": "block", "type": "html_meta"}
//       ]
//     }
//   ]
// }
//   ''';
// }

Future<String> getAceEditorTemplate() async {
  return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>Ace Editor</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.37.5/ace.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.37.5/ext-language_tools.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.37.5/theme-dracula.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.37.5/mode-html.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.14.9/beautify-html.min.js"></script>
  <style>
    body, html { margin: 0; padding: 0; width: 100%; height: 100%; overflow: hidden; background-color: #2B2B2B; }
    #editor { width: 100%; height: 100%; font-size: 12px; }
  </style>
</head>
<body>
  <div id="editor"></div>
  <script>
    ace.require("ace/ext/language_tools");
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/dracula");
    editor.session.setMode("ace/mode/html");
    editor.session.setUseWorker(false); // Fixes syntax highlighting on local WebViews
    editor.setReadOnly(true); // Faqat ko'rish uchun
    editor.setOptions({
      enableBasicAutocompletion: true,
      enableSnippets: true,
      enableLiveAutocompletion: true,
      showPrintMargin: false,
      wrap: true,
      fontSize: "11pt"
    });
    
    function setCode(code, mode) {
      if (!code) return;
      if (mode) {
        editor.session.setMode("ace/mode/" + mode);
      }
      var formattedCode = code;
      try {
        if (mode === 'html') {
          formattedCode = html_beautify(code, { indent_size: 2, wrap_line_length: 0 });
        }
      } catch(e) {}

      var current = editor.getValue();
      if(current !== formattedCode) {
        editor.setValue(formattedCode, -1);
      }
    }

    function formatCode() {
      var current = editor.getValue();
      if (!current) return;
      var formattedCode = html_beautify(current, {
        indent_size: 2,
        preserve_newlines: true,
        max_preserve_newlines: 1,
        wrap_line_length: 0,
        unformatted: ['a', 'span', 'img', 'code', 'pre', 'sub', 'sup', 'em', 'strong', 'b', 'i', 'u', 'strike', 'big', 'small', 'pre', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']
      });
      if(current !== formattedCode) {
        editor.setValue(formattedCode, -1);
      }
    }
    
    editor.session.on('change', function(delta) {
      if (window.WebBlocksApp) {
        window.WebBlocksApp.postMessage(JSON.stringify({ type: 'code_change', code: editor.getValue() }));
      }
    });
  </script>
</body>
</html>
  ''';
}

