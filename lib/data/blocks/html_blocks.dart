const String initialPageXml =
    '<xml xmlns="https://developers.google.com/blockly/xml"></xml>';

final Map<String, dynamic> htmlToolboxConfig = {
  "kind": "categoryToolbox",
  "contents": [
    {
      "kind": "category",
      "name": "Sahifa",
      "colour": "#F5A623",
      "contents": [
        {"kind": "block", "type": "html_document"},
        {"kind": "block", "type": "html_head"},
        {"kind": "block", "type": "html_body"},
        {"kind": "block", "type": "html_title"}
      ]
    },
    {
      "kind": "category",
      "name": "Tuzilma",
      "colour": "#E8732A",
      "contents": [
        {"kind": "block", "type": "html_div"},
        {"kind": "block", "type": "html_section"},
        {"kind": "block", "type": "html_span"},
        {"kind": "block", "type": "html_link"},
        {"kind": "block", "type": "html_button"},
        {"kind": "block", "type": "html_bold"},
      ]
    },
    {
      "kind": "category",
      "name": "Matn",
      "colour": "#4285F4",
      "contents": [
        {"kind": "block", "type": "html_h1"},
        {"kind": "block", "type": "html_p"},
        {"kind": "block", "type": "html_text_node"}
      ]
    },
    {
      "kind": "category",
      "name": "Atributlar",
      "colour": "#34A853",
      "contents": [
        {"kind": "block", "type": "html_attribute"},
        {"kind": "block", "type": "html_multi_attribute"},
        {"kind": "block", "type": "html_custom_attribute"}
      ]
    },
    {
      "kind": "category",
      "name": "Ro'yxatlar",
      "colour": "#27AE60",
      "contents": [
        {"kind": "block", "type": "html_ul"},
        {"kind": "block", "type": "html_li"}
      ]
    },
    {
      "kind": "category",
      "name": "Media",
      "colour": "#E74C3C",
      "contents": [
        {"kind": "block", "type": "html_img"}
      ]
    },
    {
      "kind": "category",
      "name": "Havolalar",
      "colour": "#1ABC9C",
      "contents": [
        {"kind": "block", "type": "html_a"}
      ]
    },
    {
      "kind": "category",
      "name": "Skript",
      "colour": "#E74C3C",
      "contents": [
        {"kind": "block", "type": "html_script"},
        {"kind": "block", "type": "html_custom_code"}
      ]
    }
  ]
};

const String htmlBlockDefinitions = r'''
Blockly.defineBlocksWithJsonArray([
{
  "type": "html_custom_code",
  "message0": "Custom Code: %1",
  "args0": [
    {"type": "field_input", "name": "CODE", "text": "<div></div>"}
  ],
  "previousStatement": null,
  "nextStatement": null,
  "colour": "#5B6770"
},
  {
    "type": "html_document",
    "message0": "<!DOCTYPE html> %1 %2 </html>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#F5A623",
    "tooltip": "HTML bosh sahifa",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_head",
    "message0": "<head> %1 %2 </head>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#F5A623",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_body",
    "message0": "<body> %1 %2 </body>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#F5A623",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_title",
    "message0": "<title> %1 %2 </title>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "field_input", "name": "TITLE", "text": "Website Name"}
    ],
    "colour": "#F5A623",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_text_node",
    "message0": "Matn: %1",
    "args0": [
      {"type": "field_input", "name": "TEXT", "text": "Bu yerga yozing..."}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_div",
    "message0": "<div %1 > %2 %3 </div>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_section",
    "message0": "<section %1> %2 %3 </section>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_span",
    "message0": "<span %1> %2 </span>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_value", "name": "CONTENT", "check": "String"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_link",
    "message0": "<link %1 >",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_button",
    "message0": "<button>%1 %2 %3</button>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_bold",
    "message0": "<b %1> %2 %3 </b>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E8732A",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_multi_attribute",
    "message0": "%1 %2 %3",
    "args0": [
      {"type": "input_value", "name": "ATTR1", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_value", "name": "ATTR2", "check": "Attribute"}
    ],
    "output": "Attribute",
    "colour": "#34A853"
  },
  {
    "type": "html_h1",
    "message0": "<h1 %1> %2 </h1>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "field_input", "name": "TEXT", "text": "Sarlavha 1"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_p",
    "message0": "<p %1> %2 %3 </p>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#4285F4",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_ul",
    "message0": "<ul %1> %2 %3 </ul>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#27AE60",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_li",
    "message0": "<li %1> %2 %3 </li>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#27AE60",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_a",
    "message0": "<a %1> %2 %3 </a>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#1ABC9C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_img",
    "message0": "<img %1 />",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  },
  {
    "type": "html_attribute",
    "message0": "%1 = %2 %3 ",
    "args0": [
      {
        "type": "field_dropdown",
        "name": "ATTR_NAME",
        "options": [
          ["class", "class"],
          ["id", "id"],
          ["style", "style"],
          ["src", "src"],
          ["href", "href"],
          ["alt", "alt"],
          ["type", "type"],
          ["placeholder", "placeholder"],
          ["name", "name"]
        ]
      },
    
      {"type": "field_input", "name": "ATTR_VALUE", "text": "value"},
    
      {"type": "input_value", "name": "NEXT", "check": "Attribute"}
    ],
    "output": "Attribute",
    "colour": "#34A853"
  },
  {
    "type": "html_custom_attribute",
    "message0": "%1 = %2 %3 ",
    "args0": [
      {"type": "field_input", "name": "ATTR_NAME", "text": "data-attr"},
      {"type": "field_input", "name": "ATTR_VALUE", "text": "value"},
      {"type": "input_value", "name": "NEXT", "check": "Attribute"}
    ],
    "output": "Attribute",
    "colour": "#34A853"
  },
  {
    "type": "html_script",
    "message0": "<script %1> %2 %3 </" + "script>",
    "args0": [
      {"type": "input_value", "name": "ATTR", "check": "Attribute"},
      {"type": "input_dummy"},
      {"type": "input_statement", "name": "CONTENT"}
    ],
    "colour": "#E74C3C",
    "previousStatement": null,
    "nextStatement": null
  }
]);
''';
