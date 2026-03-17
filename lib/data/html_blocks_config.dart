import 'blocks/html_blocks.dart';
import 'blocks/css_blocks.dart';
import 'blocks/js_blocks.dart';
import 'blocks/generators/block_generators.dart';

export 'blocks/html_blocks.dart';
export 'blocks/css_blocks.dart';
export 'blocks/js_blocks.dart';

// Unified JS Generator definitions used by blockly_html_template.dart
const String combinedBlockDefinitions = htmlBlockDefinitions + cssBlockDefinitions + jsBlockDefinitions + blockGenerators;
const String allBlockDefinitions = combinedBlockDefinitions;

// Toolbox config references (re-exported for use in template)
final htmlToolboxConfigRef = htmlToolboxConfig;
final cssToolboxConfigRef = cssToolboxConfig;
final jsToolboxConfigRef = jsToolboxConfig;
