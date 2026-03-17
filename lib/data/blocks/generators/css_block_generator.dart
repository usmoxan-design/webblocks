const String cssBlockGeneratorsSnippet = r'''
case 'html_custom_code': {
  out = block.getFieldValue('CODE') + '\n';
  break;
}
    case 'css_selector': {
      var rules = statementToHtml(block, 'RULES');
      out = block.getFieldValue('SELECTOR') + ' {\n' + rules + '}\n';
      break;
    }
    case 'css_property':
    case 'css_property_color':
    case 'css_custom_property': {
      out = '  ' + block.getFieldValue('PROP') + ': ' + block.getFieldValue('VALUE') + ';\n';
      break;
    }
    case 'css_unit': {
      return block.getFieldValue('NUM') + block.getFieldValue('UNIT');
    }
''';