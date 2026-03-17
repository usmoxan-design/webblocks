final Map<String, dynamic> cssToolboxConfig = {
  "kind": "categoryToolbox",
  "contents": [
    {
      "kind": "category", "name": "Selektorlar", "colour": "#2965F1",
      "contents": [
        {"kind": "block", "type": "css_selector"}
      ]
    },
    {
      "kind": "category", "name": "Xususiyatlar", "colour": "#34A853",
      "contents": [
        {"kind": "block", "type": "css_property"},
        {"kind": "block", "type": "css_property_color"},
        {"kind": "block", "type": "css_custom_property"},
        {"kind": "block", "type": "css_custom_code"}
      ]
    },
    {
      "kind": "category", "name": "O'lchamlar", "colour": "#F5A623",
      "contents": [
        {"kind": "block", "type": "css_unit"}
      ]
    },
    {
      "kind": "category", "name": "Matn va Shakl", "colour": "#9B59B6",
      "contents": [
        {"kind": "block", "type": "css_display"},
        {"kind": "block", "type": "css_text_align"},
        {"kind": "block", "type": "css_font_size"},
        {"kind": "block", "type": "css_width"},
        {"kind": "block", "type": "css_height"}
      ]
    }
  ]
};

const String cssBlockDefinitions = r'''
Blockly.defineBlocksWithJsonArray([
{
  "type": "css_custom_code",
  "message0": "Custom Code: %1",
  "args0": [
    {"type": "field_input", "name": "CODE", "text": "<div></div>"}
  ],
  "previousStatement": null,
  "nextStatement": null,
  "colour": "#5B6770"
},
  {
    "type": "css_selector",
    "message0": "%1 { %2 %3 }",
    "args0": [
      {"type": "field_input", "name": "SELECTOR", "text": "body"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "RULES"}
    ],
    "colour": "#2965F1",
    "tooltip": "CSS selektori"
  },
  {
    "type": "css_property",
    "message0": "%1 : %2 ;",
    "args0": [
      {"type": "field_input", "name": "PROP", "text": "margin"},
      {"type": "field_input", "name": "VALUE", "text": "0px"}
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_property_color",
    "message0": "%1 : %2 ;",
    "args0": [
      {
        "type": "field_dropdown",
        "name": "PROP",
        "options": [
          ["color", "color"],
          ["background-color", "background-color"],
          ["border-color", "border-color"]
        ]
      },
      {"type": "field_colour", "name": "VALUE", "colour": "#ff0000"}
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_custom_property",
    "message0": "%1 : %2 ;",
    "args0": [
      {"type": "field_input", "name": "PROP", "text": "border-radius"},
      {"type": "field_input", "name": "VALUE", "text": "8px"}
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_unit",
    "message0": "%1 %2",
    "args0": [
      {"type": "field_number", "name": "NUM", "value": 10},
      {
        "type": "field_dropdown",
        "name": "UNIT",
        "options": [
          ["px", "px"],
          ["%", "%"],
          ["em", "em"],
          ["rem", "rem"],
          ["vh", "vh"],
          ["vw", "vw"]
        ]
      }
    ],
    "output": "String",
    "colour": "#F5A623"
  },
  {
    "type": "css_display",
    "message0": "display : %1 ;",
    "args0": [
      {
        "type": "field_dropdown",
        "name": "VALUE",
        "options": [
          ["block", "block"],
          ["inline", "inline"],
          ["inline-block", "inline-block"],
          ["flex", "flex"],
          ["grid", "grid"],
          ["none", "none"]
        ]
      }
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_text_align",
    "message0": "text-align : %1 ;",
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
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_font_size",
    "message0": "font-size : %1 ;",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "16px"}
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_width",
    "message0": "width : %1 ;",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "100%"}
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "css_height",
    "message0": "height : %1 ;",
    "args0": [
      {"type": "field_input", "name": "VALUE", "text": "100px"}
    ],
    "colour": "#34A853",
    "previousStatement": null,
    "nextStatement": null
  }
]);
''';
