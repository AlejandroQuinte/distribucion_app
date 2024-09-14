part of 'theme_cubit.dart';

enum ThemeType { light, dark, blue }

extension ThemeTypeExtension on ThemeType {
  String get displayName {
    switch (this) {
      case ThemeType.light:
        return 'Light Mode';
      case ThemeType.dark:
        return 'Dark Mode';
      case ThemeType.blue:
        return 'Blue Theme';
      default:
        return '';
    }
  }
}

class ThemeState {
  final ThemeData currentTheme;
  final ThemeType themeType;
  ThemeState(this.currentTheme, {this.themeType = ThemeType.light});
}

class ThemeLight extends ThemeState {
  ThemeLight() : super(AppTheme.lightTheme, themeType: ThemeType.light);
}

class ThemeDark extends ThemeState {
  ThemeDark() : super(AppTheme.darkTheme, themeType: ThemeType.dark);
}

class ThemeBlue extends ThemeState {
  ThemeBlue() : super(AppTheme.blueTheme, themeType: ThemeType.blue);
}
