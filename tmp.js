
// === PAGE BLOCKS ===
Blockly.defineBlocksWithJsonArray([
  // HTML Document
  {
    "type": "html_document",
    "message0": "<html> %1 %2 %3 </html>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "HEAD_CONTENT", "check": "html_head"},
      {"type": "input_statement", "name": "BODY_CONTENT", "check": "html_body"}
    ],
    "colour": "#F5A623",
    "tooltip": "HTML hujjat",
    "output": null
  },
  // HEAD
  {
    "type": "html_head",
    "message0": "<head> %1 %2 </head>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#F5A623",
    "tooltip": "HTML head",
    "previousStatement": null,
    "nextStatement": null
  },
  // BODY
  {
    "type": "html_body",
    "message0": "<body> %1 %2 </body>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#F5A623",
    "tooltip": "HTML body",
    "previousStatement": null,
    "nextStatement": null
  },
  // TITLE
  {
    "type": "html_title",
    "message0": "<title> %1 </title>",
    "args0": [
      {"type": "field_input", "name": "TITLE", "text": "Website Name"}
    ],
    "colour": "#F5A623",
    "tooltip": "Sahifa sarlavhasi",
    "previousStatement": null,
    "nextStatement": null
  },
  // TEXT NODE
  {
    "type": "html_text_node",
    "message0": "Text: %1",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Matn kiriting..."}
    ],
    "colour": "#4285F4",
    "tooltip": "Matn bloki",
    "previousStatement": null,
    "nextStatement": null
  },

  // === STRUCTURE BLOCKS ===
  {
    "type": "html_div",
    "message0": "<div> %1 %2 </div>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "tooltip": "Div bloki",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_section",
    "message0": "<section> %1 %2 </section>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "tooltip": "Section bloki",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_article",
    "message0": "<article> %1 %2 </article>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "tooltip": "Article bloki",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_nav",
    "message0": "<nav> %1 %2 </nav>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "tooltip": "Navigation bloki",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_header",
    "message0": "<header> %1 %2 </header>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_footer",
    "message0": "<footer> %1 %2 </footer>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_main",
    "message0": "<main> %1 %2 </main>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_span",
    "message0": "<span> %1 </span>",
    "args0": [
      {"type": "input_value", "name": "CONTENT", "check": "String"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },

  // === TEXT BLOCKS ===
  {
    "type": "html_h1",
    "message0": "<h1> %1 </h1>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Sarlavha 1"}
    ],
    "colour": "#4285F4",
    "tooltip": "H1 sarlavha",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_h2",
    "message0": "<h2> %1 </h2>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Sarlavha 2"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_h3",
    "message0": "<h3> %1 </h3>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Sarlavha 3"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_p",
    "message0": "<p> %1 %2 </p>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#4285F4",
    "tooltip": "Paragraf",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_strong",
    "message0": "<strong> %1 </strong>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Qalin matn"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_em",
    "message0": "<em> %1 </em>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Kursiv matn"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_br",
    "message0": "<br />",
    "args0": [],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_hr",
    "message0": "<hr />",
    "args0": [],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },

  // === ATTRIBUTE BLOCKS ===
  {
    "type": "html_attribute_id",
    "message0": "id= %1",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "my-id"}
    ],
    "colour": "#34A853",
    "output": "String",
    "tooltip": "ID atribut"
  },
  {
    "type": "html_attribute_class",
    "message0": "class= %1",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "my-class"}
    ],
    "colour": "#34A853",
    "output": "String",
    "tooltip": "CSS class atribut"
  },
  {
    "type": "html_attribute_href",
    "message0": "href= %1",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "https://example.com"}
    ],
    "colour": "#34A853",
    "output": "String"
  },
  {
    "type": "html_attribute_src",
    "message0": "src= %1",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "image.jpg"}
    ],
    "colour": "#34A853",
    "output": "String"
  },
  {
    "type": "html_attribute_alt",
    "message0": "alt= %1",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "rasm tavsifi"}
    ],
    "colour": "#34A853",
    "output": "String"
  },

  // === STYLE BLOCKS ===
  {
    "type": "html_style_block",
    "message0": "<style> %1 %2 </style>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_inline_style",
    "message0": "style= %1",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "color: red;"}
    ],
    "colour": "#9B59B6",
    "output": "String"
  },
  {
    "type": "html_css_rule",
    "message0": "%1 { %2 %3 }",
    "args0": [
      {"type": "field_input", "name": "SELECTOR", "text": ".class"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_css_color",
    "message0": "color: %1",
    "args0": [
      {"type": "field_colour", "name": "VALUE", "colour": "#ff0000"}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_css_bg_color",
    "message0": "background-color: %1",
    "args0": [
      {"type": "field_colour", "name": "VALUE", "colour": "#ffffff"}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_css_font_size",
    "message0": "font-size: %1 px",
    "args0": [
      {"type": "field_number", "name": "VALUE", "value": 16, "min": 1, "max": 200}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_css_padding",
    "message0": "padding: %1 px",
    "args0": [
      {"type": "field_number", "name": "VALUE", "value": 10, "min": 0}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_css_margin",
    "message0": "margin: %1 px",
    "args0": [
      {"type": "field_number", "name": "VALUE", "value": 10, "min": 0}
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_css_text_align",
    "message0": "text-align: %1",
    "args0": [
      {
        "type": "field_dropdown",
        "name": "VALUE",
        "options": [
          ["left", "left"],
          ["center", "center"],
          ["right", "right"],
          ["justify", "justify"]
        ]
      }
    ],
    "colour": "#9B59B6",
    "previousStatement": null,
    "nextStatement": null
  },

  // === MEDIA BLOCKS ===
  {
    "type": "html_img",
    "message0": "<img src= %1 alt= %2 />",
    "args0": [
      {"type": "field_input", "name": "SRC", "text": "image.jpg"},
      {"type": "field_input", "name": "ALT", "text": "rasm"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_video",
    "message0": "<video> %1 %2 </video>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_audio",
    "message0": "<audio> %1 %2 </audio>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_iframe",
    "message0": "<iframe src= %1 />",
    "args0": [
      {"type": "field_input", "name": "SRC", "text": "https://example.com"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },

  // === LINK BLOCKS ===
  {
    "type": "html_a",
    "message0": "<a href= %1 > %2 %3 </a>",
    "args0": [
      {"type": "field_input", "name": "HREF", "text": "#"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#1ABC9C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_button",
    "message0": "<button> %1 </button>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Tugma"}
    ],
    "colour": "#1ABC9C",
    "previousStatement": null,
    "nextStatement": null
  },

  // === FORM BLOCKS ===
  {
    "type": "html_form",
    "message0": "<form> %1 %2 </form>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#3498DB",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_input",
    "message0": "<input type= %1 placeholder= %2 />",
    "args0": [
      {
        "type": "field_dropdown",
        "name": "TYPE",
        "options": [
          ["text", "text"],
          ["email", "email"],
          ["password", "password"],
          ["number", "number"],
          ["submit", "submit"]
        ]
      },
      {"type": "field_input", "name": "PLACEHOLDER", "text": "Kiriting..."}
    ],
    "colour": "#3498DB",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_label",
    "message0": "<label> %1 </label>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Label"}
    ],
    "colour": "#3498DB",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_textarea",
    "message0": "<textarea> %1 </textarea>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": ""}
    ],
    "colour": "#3498DB",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_select",
    "message0": "<select> %1 %2 </select>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#3498DB",
    "previousStatement": null,
    "nextStatement": null
  },

  // === TABLE BLOCKS ===
  {
    "type": "html_table",
    "message0": "<table> %1 %2 </table>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E67E22",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_tr",
    "message0": "<tr> %1 %2 </tr>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E67E22",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_td",
    "message0": "<td> %1 </td>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Katak"}
    ],
    "colour": "#E67E22",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_th",
    "message0": "<th> %1 </th>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Sarlavha"}
    ],
    "colour": "#E67E22",
    "previousStatement": null,
    "nextStatement": null
  },

  // === LIST BLOCKS ===
  {
    "type": "html_ul",
    "message0": "<ul> %1 %2 </ul>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#27AE60",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_ol",
    "message0": "<ol> %1 %2 </ol>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#27AE60",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_li",
    "message0": "<li> %1 </li>",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Element"}
    ],
    "colour": "#27AE60",
    "previousStatement": null,
    "nextStatement": null
  },

  // === SCRIPT BLOCKS ===
  {
    "type": "html_script",
    "message0": "<script> %1 %2 \\x3C/script>",
    "args0": [
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_link_css",
    "message0": "<link rel=stylesheet href= %1 />",
    "args0": [
      {"type": "field_input", "name": "HREF", "text": "styles.css"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_meta",
    "message0": "<meta %1 = %2 />",
    "args0": [
      {
        "type": "field_dropdown",
        "name": "ATTR",
        "options": [
          ["charset", "charset"],
          ["name", "name"],
          ["http-equiv", "http-equiv"]
        ]
      },
      {"type": "field_input", "name": "VALUE", "text": "UTF-8"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  }
]);

// === HTML KOD GENERATSIYA ===
// Bu funksiyalar XML'dan HTML kodini yaratadi
function generateHtml(workspace) {
  var blocks = workspace.getTopBlocks(true);
  var html = '';
  for (var block of blocks) {
    html += blockToHtml(block);
  }
  return html;
}

function blockToHtml(block) {
  if (!block || block.disabled) return '';
  var type = block.type;
  var out = '';

  switch(type) {
    case 'html_document': {
      var headContent = statementToHtml(block, 'HEAD_CONTENT');
      var bodyContent = statementToHtml(block, 'BODY_CONTENT');
      out = '<!DOCTYPE html>\n<html>\n' + headContent + bodyContent + '</html>';
      break;
    }
    case 'html_head': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<head>\n' + content + '</head>\n';
      break;
    }
    case 'html_body': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<body>\n' + content + '</body>\n';
      break;
    }
    case 'html_title': {
      out = '<title>' + block.getFieldValue('TITLE') + '</title>\n';
      break;
    }
    case 'html_text_node': {
      out = block.getFieldValue('TEXT') + '\n';
      break;
    }
    case 'html_div': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<div>\n' + content + '</div>\n';
      break;
    }
    case 'html_section': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<section>\n' + content + '</section>\n';
      break;
    }
    case 'html_article': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<article>\n' + content + '</article>\n';
      break;
    }
    case 'html_nav': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<nav>\n' + content + '</nav>\n';
      break;
    }
    case 'html_header': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<header>\n' + content + '</header>\n';
      break;
    }
    case 'html_footer': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<footer>\n' + content + '</footer>\n';
      break;
    }
    case 'html_main': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<main>\n' + content + '</main>\n';
      break;
    }
    case 'html_span': {
      out = '<span>' + block.getFieldValue('CONTENT') + '</span>\n';
      break;
    }
    case 'html_h1': out = '<h1>' + block.getFieldValue('TEXT') + '</h1>\n'; break;
    case 'html_h2': out = '<h2>' + block.getFieldValue('TEXT') + '</h2>\n'; break;
    case 'html_h3': out = '<h3>' + block.getFieldValue('TEXT') + '</h3>\n'; break;
    case 'html_p': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<p>' + content + '</p>\n';
      break;
    }
    case 'html_strong': out = '<strong>' + block.getFieldValue('TEXT') + '</strong>\n'; break;
    case 'html_em': out = '<em>' + block.getFieldValue('TEXT') + '</em>\n'; break;
    case 'html_br': out = '<br />\n'; break;
    case 'html_hr': out = '<hr />\n'; break;
    case 'html_img': {
      out = '<img src="' + block.getFieldValue('SRC') + '" alt="' + block.getFieldValue('ALT') + '" />\n';
      break;
    }
    case 'html_iframe': {
      out = '<iframe src="' + block.getFieldValue('SRC') + '"></iframe>\n';
      break;
    }
    case 'html_a': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<a href="' + block.getFieldValue('HREF') + '">\n' + content + '</a>\n';
      break;
    }
    case 'html_button': {
      out = '<button>' + block.getFieldValue('TEXT') + '</button>\n';
      break;
    }
    case 'html_form': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<form>\n' + content + '</form>\n';
      break;
    }
    case 'html_input': {
      out = '<input type="' + block.getFieldValue('TYPE') + '" placeholder="' + block.getFieldValue('PLACEHOLDER') + '" />\n';
      break;
    }
    case 'html_label': out = '<label>' + block.getFieldValue('TEXT') + '</label>\n'; break;
    case 'html_textarea': out = '<textarea>' + block.getFieldValue('TEXT') + '</textarea>\n'; break;
    case 'html_table': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<table>\n' + content + '</table>\n';
      break;
    }
    case 'html_tr': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<tr>\n' + content + '</tr>\n';
      break;
    }
    case 'html_td': out = '<td>' + block.getFieldValue('TEXT') + '</td>\n'; break;
    case 'html_th': out = '<th>' + block.getFieldValue('TEXT') + '</th>\n'; break;
    case 'html_ul': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<ul>\n' + content + '</ul>\n';
      break;
    }
    case 'html_ol': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<ol>\n' + content + '</ol>\n';
      break;
    }
    case 'html_li': out = '<li>' + block.getFieldValue('TEXT') + '</li>\n'; break;
    case 'html_style_block': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<style>\n' + content + '</style>\n';
      break;
    }
    case 'html_css_rule': {
      var content = statementToHtml(block, 'CONTENT');
      out = block.getFieldValue('SELECTOR') + ' {\n' + content + '}\n';
      break;
    }
    case 'html_css_color': {
      out = 'color: ' + block.getFieldValue('VALUE') + ';\n';
      break;
    }
    case 'html_css_bg_color': {
      out = 'background-color: ' + block.getFieldValue('VALUE') + ';\n';
      break;
    }
    case 'html_css_font_size': {
      out = 'font-size: ' + block.getFieldValue('VALUE') + 'px;\n';
      break;
    }
    case 'html_css_padding': {
      out = 'padding: ' + block.getFieldValue('VALUE') + 'px;\n';
      break;
    }
    case 'html_css_margin': {
      out = 'margin: ' + block.getFieldValue('VALUE') + 'px;\n';
      break;
    }
    case 'html_css_text_align': {
      out = 'text-align: ' + block.getFieldValue('VALUE') + ';\n';
      break;
    }
    case 'html_script': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<script>\n' + content + '</' + 'script>\n';
      break;
    }
    case 'html_link_css': {
      out = '<link rel="stylesheet" href="' + block.getFieldValue('HREF') + '" />\n';
      break;
    }
    case 'html_meta': {
      out = '<meta ' + block.getFieldValue('ATTR') + '="' + block.getFieldValue('VALUE') + '" />\n';
      break;
    }
    default:
      out = '';
  }

  var next = block.nextConnection && block.nextConnection.targetBlock();
  if (next) {
    out += blockToHtml(next);
  }
  return out;
}

function statementToHtml(block, name) {
  var conn = block.getInput(name);
  if (!conn || !conn.connection || !conn.connection.targetBlock()) return '';
  return blockToHtml(conn.connection.targetBlock());
}
