import 'html_block_generator.dart';
import 'css_block_generator.dart';
import 'js_block_generator.dart';

const String blockGenerators = r'''
function getBlockAttributes(block) {
  var attrs = '';
  var child = block.getInputTargetBlock('ATTR');
  while (child) {
    var name = child.getFieldValue('ATTR_NAME');
    var val = child.getFieldValue('ATTR_VALUE');
    if (name && val !== null && val !== undefined) {
      attrs += ' ' + name + '="' + val + '"';
    }
    child = child.getInputTargetBlock('NEXT');
  }
  return attrs;
}

function generateHtml(workspace) {
  var blocks = workspace.getTopBlocks(true);
  var out = '';
  for (var i = 0; i < blocks.length; i++) {
    out += blockToHtml(blocks[i]);
  }
  return out;
}

function blockToHtml(block) {
  if (!block || block.disabled) return '';
  var type = block.type;
  var out = '';

  var attrStr = '';
  if (block.getInput('ATTR')) {
    attrStr = getBlockAttributes(block);
  }

  switch(type) {
''' + htmlBlockGeneratorsSnippet + cssBlockGeneratorsSnippet + jsBlockGeneratorsSnippet + r'''
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
  var target = block.getInputTargetBlock(name);
  return target ? blockToHtml(target) : '';
}

function valueToHtml(block, name) {
  var target = block.getInputTargetBlock(name);
  return target ? blockToHtml(target) : '';
}
''';