import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isDarkMode = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode => _prefs.getBool("isDarkMode") ?? _isDarkMode;
  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool("isDarkMode", value);
  }

  static ThemeType get themeType {
    final index = _prefs.getInt("themeType") ?? 0;
    return ThemeType.values[index];
  }

  static set themeType(ThemeType value) {
    _prefs.setInt("themeType", value.index);
  }
}
