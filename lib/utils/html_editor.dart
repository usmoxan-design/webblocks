import 'package:flutter/material.dart';

class HtmlSyntaxController extends TextEditingController {
  final Map<String, TextStyle> theme = {
    'tag':
        const TextStyle(color: Color(0xFFE06C75), fontWeight: FontWeight.bold),
    'attr': const TextStyle(color: Color(0xFFD19A66)),
    'string': const TextStyle(color: Color(0xFF98C379)),
    'comment':
        const TextStyle(color: Color(0xFF5C6370), fontStyle: FontStyle.italic),
    'text': const TextStyle(color: Color(0xFFABB2BF)),
    'bracket': const TextStyle(color: Color(0xFF56B6C2)),
  };

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final String currentText = text;

    if (currentText.isEmpty) {
      return TextSpan(
          style: style?.copyWith(color: theme['text']?.color), text: '');
    }

    List<TextSpan> spans = [];
    final RegExp tokenizer = RegExp(
        r'(<!--.*?-->)|(</?[a-zA-Z0-9\-]+)|([a-zA-Z0-9\-]+(?=\s*=))|("[^"]*"|'
        "'"
        r"[^']*"
        "'"
        r')|(<|>)|([^<>"'
        "'"
        r'\s]+)|(\s+)',
        dotAll: true);

    for (final Match m in tokenizer.allMatches(currentText)) {
      if (m.group(1) != null) {
        spans.add(TextSpan(text: m.group(1), style: theme['comment']));
      } else if (m.group(2) != null) {
        spans.add(TextSpan(text: m.group(2), style: theme['tag']));
      } else if (m.group(3) != null) {
        spans.add(TextSpan(text: m.group(3), style: theme['attr']));
      } else if (m.group(4) != null) {
        spans.add(TextSpan(text: m.group(4), style: theme['string']));
      } else if (m.group(5) != null) {
        spans.add(TextSpan(text: m.group(5), style: theme['bracket']));
      } else if (m.group(6) != null || m.group(7) != null) {
        spans.add(TextSpan(text: m.group(0), style: theme['text']));
      }
    }

    return TextSpan(
        style: style?.copyWith(color: theme['text']?.color), children: spans);
  }
}

String formatHtmlCode(String html) {
  String cleaned = html.replaceAll(RegExp(r'>\s+<'), '><').trim();
  final RegExp tagRegex = RegExp(r'</?(?:[a-zA-Z0-9\-]+)(?:[^>]*?)>|[^<]+');
  final Iterable<Match> matches = tagRegex.allMatches(cleaned);

  int indentLevel = 0;
  final StringBuffer buffer = StringBuffer();
  const String indentString = '  '; // 2 spaces
  const Set<String> selfClosing = {'img', 'br', 'hr', 'input', 'meta', 'link'};

  for (final Match m in matches) {
    String token = m.group(0)!.trim();
    if (token.isEmpty) continue;

    if (token.startsWith('</')) {
      indentLevel = (indentLevel > 0) ? indentLevel - 1 : 0;
      buffer.write('\n${indentString * indentLevel}$token');
    } else if (token.startsWith('<') && !token.startsWith('<!--')) {
      buffer.write('\n${indentString * indentLevel}$token');
      final tagNameMatch = RegExp(r'<([a-zA-Z0-9\-]+)').firstMatch(token);
      final tagName =
          tagNameMatch != null ? tagNameMatch.group(1)!.toLowerCase() : '';
      if (!selfClosing.contains(tagName) && !token.endsWith('/>')) {
        indentLevel++;
      }
    } else {
      buffer.write('\n${indentString * indentLevel}$token');
    }
  }
  return buffer
      .toString()
      .trim()
      .replaceAll(RegExp(r'\n{2,}'), '\n'); // Remove extra newlines
}
