const String htmlBlockGeneratorsSnippet = r'''
case 'html_custom_code': {
  out = block.getFieldValue('CODE') + '\n';
  break;
}
    case 'html_document': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<html>' + attrStr + '\n' + content + '\n</html>';
      break;
    }
    case 'html_head': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<head' + attrStr + '>\n' + content + '</head>\n';
      break;
    }
    case 'html_body': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<body' + attrStr + '>\n' + content + '</body>\n';
      break;
    }
    case 'html_title': {
      out = '<title' + attrStr + '>' + block.getFieldValue('TITLE') + '</title>\n';
      break;
    }
    case 'html_text_node': {
      out = block.getFieldValue('TEXT') + '\n';
      break;
    }
    case 'html_div': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<div' + attrStr + '>\n' + content + '</div>\n';
      break;
    }
    case 'html_section': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<section' + attrStr + '>\n' + content + '</section>\n';
      break;
    }
    case 'html_span': {
      var content = block.getFieldValue('CONTENT') || '';
      out = '<span' + attrStr + '>' + content + '</span>\n';
      break;
    }
    case 'html_link': {
      out = '<link' + attrStr + '>\n';
      break;
    }
    case 'html_button': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<button' + attrStr + '>\n' + content + '</button>\n';
      break;
    }

    case 'html_bold': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<b' + attrStr + '>\n' + content + '</b>\n';
      break;
    }
    case 'html_multi_attribute': {
      var a1 = valueToHtml(block, 'ATTR1');
      var a2 = valueToHtml(block, 'ATTR2');
      return a1 + ' ' + a2;
    }
    case 'html_h1':
      out = '<h1' + attrStr + '>' + block.getFieldValue('TEXT') + '</h1>\n';
      break;
    case 'html_p': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<p' + attrStr + '>\n' + content + '</p>\n';
      break;
    }
    case 'html_ul': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<ul' + attrStr + '>\n' + content + '</ul>\n';
      break;
    }
    case 'html_li': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<li' + attrStr + '>' + content + '</li>\n';
      break;
    }
    case 'html_a': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<a' + attrStr + '>\n' + content + '</a>\n';
      break;
    }
    case 'html_img': {
      out = '<img' + attrStr + ' />\n';
      break;
    }
    case 'html_script': {
      var content = statementToHtml(block, 'CONTENT');
      out = '<script' + attrStr + '>\n' + content + '</' + 'script>\n';
      break;
    }
''';
