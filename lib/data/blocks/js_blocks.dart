final Map<String, dynamic> jsToolboxConfig = {
  "kind": "categoryToolbox",
  "contents": [
    {
      "kind": "category",
      "name": "O'zgaruvchilar",
      "colour": "#F0DB4F",
      "contents": [
        {"kind": "block", "type": "js_var_def"},
        {"kind": "block", "type": "js_var_get"},
        {"kind": "block", "type": "js_var_set"},
        {"kind": "block", "type": "connect_id"}
      ]
    },
    {
      "kind": "category",
      "name": "Logika",
      "colour": "#4285F4",
      "contents": [
        {"kind": "block", "type": "js_if"},
        {"kind": "block", "type": "js_if_else"},
        {"kind": "block", "type": "js_compare"}
      ]
    },
    {
      "kind": "category",
      "name": "DOM",
      "colour": "#E74C3C",
      "contents": [
        {"kind": "block", "type": "js_console_log"},
        {"kind": "block", "type": "js_alert"},
        {"kind": "block", "type": "js_get_element"},
        {"kind": "block", "type": "js_add_event_listener"}
      ]
    },
    {
      "kind": "category",
      "name": "Funksiyalar",
      "colour": "#1ABC9C",
      "contents": [
        {"kind": "block", "type": "js_function"},
        {"kind": "block", "type": "js_custom_code"}
      ]
    }
  ]
};

const String jsBlockDefinitions = r'''
Blockly.defineBlocksWithJsonArray([
{
  "type": "js_custom_code",
  "message0": "Custom Code: %1",
  "args0": [
    {"type": "field_input", "name": "CODE", "text": "<div></div>"}
  ],
  "previousStatement": null,
  "nextStatement": null,
  "colour": "#5B6770"
},
  {
    "type": "js_var_def",
    "message0": "var %1 = %2 ;",
    "args0": [
      {"type": "field_input", "name": "VAR", "text": "x"},
      {"type": "field_input", "name": "VAL", "text": "0"}
    ],
    "colour": "#F0DB4F",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "js_console_log",
    "message0": "console.log( %1 );",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Hello World"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "js_alert",
    "message0": "alert( %1 );",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Salom!"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "js_if",
    "message0": "if ( %1 ) { %2 %3 }",
    "args0": [
      {"type": "input_value", "name": "COND", "check": "Boolean"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "DO"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
   {
    "type": "js_if_else",
    "message0": "if ( %1 ) { %2 %3 } else { %4 %5 } ",
    "args0": [
      {"type": "input_value", "name": "COND", "check": "Boolean"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "DO"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "DO2"},
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "js_compare",
    "message0": "%1 %2 %3",
    "args0": [
      {"type": "field_input", "name": "A", "text": "x"},
      {
        "type": "field_dropdown",
        "name": "OP",
        "options": [
          ["==", "=="],
          ["===", "==="],
          ["!=", "!="],
          ["<", "<"],
          [">", ">"],
          ["<=", "<="],
          [">=", ">="]
        ]
      },
      {"type": "field_input", "name": "B", "text": "10"}
    ],
    "output": "Boolean",
    "colour": "#4285F4"
  },
  {
    "type": "js_var_get",
    "message0": "%1",
    "args0": [
      {"type": "field_input", "name": "VAR", "text": "x"}
    ],
    "output": "Attribute",
    "colour": "#F0DB4F"
  },
  {
    "type": "js_var_set",
    "message0": "%1 = %2 ;",
    "args0": [
      {"type": "field_input", "name": "VAR", "text": "x"},
      {"type": "field_input", "name": "VAL", "text": "10"}
    ],
    "colour": "#F0DB4F",
    "previousStatement": null,
    "nextStatement": null
  },
    {
  "type": "connect_id",
  "message0": "const %1 = %2",
  "args0": [
    {
      "type": "field_input",
      "name": "ATTR",
      "text": ""
    },
    {
      "type": "input_value",
      "name": "CONTENT",
      "check": "Attribute"
    }
  ],
  "colour": "#9A33DA",
  "previousStatement": null,
  "nextStatement": null
  },
  {
    "type": "js_get_element",
    "message0": "document.getElementById( %1 )",
    "args0": [
      {"type": "field_input", "name": "ID", "text": "elementId"}
    ],
    "output": null,
    "colour": "#E74C3C"
  },
  {
    "type": "js_function",
    "message0": "function %1 ( %2 ) { %3 %4 }",
    "args0": [
      {"type": "field_input", "name": "NAME", "text": "myFunction"},
      {"type": "field_input", "name": "PARAMS", "text": ""},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#1ABC9C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "js_add_event_listener",
    "message0": "%1.addEventListener( %2 , function() { %3 %4 });",
    "args0": [
      {"type": "field_input", "name": "ELEMENT", "text": "button"},
      {
        "type": "field_dropdown",
        "name": "EVENT",
        "options": [
          ["click", "click"],
          ["mouseover", "mouseover"],
          ["mouseout", "mouseout"],
          ["keydown", "keydown"],
          ["keyup", "keyup"],
          ["submit", "submit"]
        ]
      },
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "DO"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  }
]);
''';
