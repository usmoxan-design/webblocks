# WebBlocks: Bloklar yaratish qo'llanmasi (Developer Guide)

Ushbu hujjat WebBlocks loyihasida yangi bloklarni qanday qo'shish va ularning generatsiya mantiqini qanday sozlashni tushuntiradi. Asosiy konfiguratsiya `lib/data/html_blocks_config.dart` faylida jamlangan.

## 1. Blok Turlari

Blockly-da bloklar bir-biriga ulanish turiga qarab bir necha xil bo'ladi:

### A. Statement Block (Tishli blok)
Bu bloklar vertikal ravishda bir-biriga tirkaladi.
- **previousStatement**: Yuqoridan ulanish imkoniyati.
- **nextStatement**: Pastdan ulanish imkoniyati.
- **input_statement**: Ichiga boshqa bloklarni qabul qilish (nesting).

**Misol (div):**
```javascript
{
  "type": "html_div",
  "message0": "<div> %1 %2 </div>",
  "args0": [
    {"type": "input_value", "name": "ATTR", "check": "Attribute"}, // Atributlar uchun
    {"type": "input_statement", "name": "CONTENT"} // Ichki bloklar uchun
  ],
  "previousStatement": null,
  "nextStatement": null
}
```

### B. Value Block (Aylana blok)
Bu bloklar boshqa bloklarning kirish qismlariga (input_value) ulanadi. Odatda atributlar yoki o'zgaruvchilar uchun ishlatiladi.
- **output**: Chiqish qiymati turi (masalan, "Attribute" yoki "String").

**Misol (attribute):**
```javascript
{
  "type": "html_attribute",
  "message0": "%1 = %2",
  "args0": [
    {"type": "field_input", "name": "NAME", "text": "class"},
    {"type": "field_input", "name": "VALUE", "text": "container"}
  ],
  "output": "Attribute"
}
```

## 2. Toolbox (Asboblar qutisi) Konfiguratsiyasi

Toolbox - bu chap tarafdagi kategoriyalar menyusi. U `Map` formatida saqlanadi:

```dart
final Map<String, dynamic> htmlToolboxConfig = {
  "kind": "categoryToolbox",
  "contents": [
    {
      "kind": "category", 
      "name": "Matn", 
      "colour": "#4285F4",
      "contents": [
        {"kind": "block", "type": "html_h1"},
        {"kind": "block", "type": "html_p"}
      ]
    }
  ]
};
```

## 3. Kod Generatsiyasi (Generator)

Bloklardan kod yaratish `blockToHtml` funksiyasi ichida amalga oshiriladi. Har bir `type` uchun `case` qo'shilishi kerak:

```javascript
case 'html_h1': 
  // Atributlarni olish (agar blokda bo'lsa)
  var attrs = getBlockAttributes(block);
  // Maydon qiymatini olish
  var text = block.getFieldValue('TEXT');
  out = '<h1' + attrs + '>' + text + '</h1>\n'; 
  break;
```

### Muhim funksiyalar:
- `block.getFieldValue('NAME')`: Input field-dagi matnni oladi.
- `statementToHtml(block, 'NAME')`: `input_statement` ichidagi barcha bloklarni kodga aylantiradi.
- `blockToHtml(block.getInputTargetBlock('NAME'))`: `input_value` orqali ulangan blok kodini oladi.

## 4. Yangi Blok Qo'shish Bosqichlari

1. `htmlBlockDefinitions` ichidagi `Blockly.defineBlocksWithJsonArray` ga blok dizaynini (JSON) qo'shing.
2. `blockToHtml` funksiyasidagi `switch` blokiga yangi `case` qo'shib, qanday kod yaratishini yozing.
3. Kerakli toolboxga (`htmlToolboxConfig`, `cssToolboxConfig` yoki `jsToolboxConfig`) blok turini qo'shing.

---
**Maslahat:** Agar blok atribut qabul qilishi kerak bo'lsa, `args0` ga `{"type": "input_value", "name": "ATTR", "check": "Attribute"}` qo'shishni unutmang.
