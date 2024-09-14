import 'package:html_unescape/html_unescape.dart';

class StringUtils {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static String capitalizeAll(String s) {
    var words = s.split(' ');
    var capitalized = words.map((word) => capitalize(word));
    return capitalized.join(' ');
  }

  static String capitalizeFirstOfEach(String s) {
    var words = s.split(' ');
    var capitalized = words.map((word) => capitalize(word[0]));
    return capitalized.join(' ');
  }

  static String capitalizeFirstOfEachWord(String s) {
    var words = s.split(' ');
    var capitalized = words.map((word) => capitalize(word));
    return capitalized.join(' ');
  }

  static String getStringBetweenFirst(
      String s, String start, String end, bool reaplaceFinal) {
    final re = RegExp('StringBetweenFirst(.*?)');

    String content = s.replaceFirst(start, 'StringBetweenFirst');

    if (reaplaceFinal) {
      content = content.replaceFirst(end, 'StringBetweenFirst');
    } else {
      content = content.replaceFirst(end, '${end}StringBetweenFirst');
    }

    if (content.contains('StringBetweenFirst')) {
      content = content.split(re)[1];
    } else {
      content = "NOTFOUND";
    }
    return content;
  }

  static String getUnescapedString(String s, [bool isHtml = true]) {
    String unescaped = HtmlUnescape().convert(s);
    if (isHtml) {
      RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
      unescaped = unescaped.replaceAll(exp, '');
    }
    return unescaped;
  }
}
