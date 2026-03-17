const String jsBlockGeneratorsSnippet = r'''
case 'js_custom_code': {
  out = block.getFieldValue('CODE') + '\n';
  break;
}
    case 'js_var_def': {
      out = 'var ' + block.getFieldValue('VAR') + ' = ' + block.getFieldValue('VAL') + ';\n';
      break;
    }
    case 'js_var_set': {
      out = block.getFieldValue('VAR') + ' = ' + block.getFieldValue('VAL') + ';\n';
      break;
    }
    case 'js_console_log': {
      out = 'console.log(' + block.getFieldValue('TEXT') + ');\n';
      break;
    }
    case 'js_alert': {
      out = 'alert("' + block.getFieldValue('TEXT') + '");\n';
      break;
    }
    case 'js_if': {
      var cond = valueToHtml(block, 'COND') || 'true';
      var branch = statementToHtml(block, 'DO');
      out = 'if (' + cond + ') {\n' + branch + '}\n';
      break;
    }
    case 'js_if_else': {
      var cond = valueToHtml(block, 'COND') || 'true';
      var branch = statementToHtml(block, 'DO');
      var branch2 = statementToHtml(block, 'DO2');
      out = 'if (' + cond + ') {\n' + branch + '}\n else {\n' + branch2 + '}\n';
      break;
    }
    case 'js_compare': {
      return block.getFieldValue('A') + ' ' + block.getFieldValue('OP') + ' ' + block.getFieldValue('B');
    }
    case 'js_function': {
      var name = block.getFieldValue('NAME');
      var params = block.getFieldValue('PARAMS');
      var content = statementToHtml(block, 'CONTENT');
      out = 'function ' + name + '(' + params + ') {\n' + content + '}\n';
      break;
    }
    case 'js_get_element': {
       return 'document.getElementById("' + block.getFieldValue('ID') + '")';
    }
    case 'js_var_get': {
       return block.getFieldValue('VAR');
    }
    case 'connect_id': {
      var attr = block.getFieldValue('ATTR');
      var content = valueToHtml(block, 'CONTENT');
      out = 'const ' + attr + ' = ' + content + ';\n';
      break;
    }
    case 'js_add_event_listener': {
      var element = block.getFieldValue('ELEMENT');
      var event = block.getFieldValue('EVENT');
      var branch = statementToHtml(block, 'DO');
      out = element + '.addEventListener("' + event + '", function() {\n' + branch + '});\n';
      break;
    }
''';
