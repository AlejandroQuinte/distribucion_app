import 'package:bloc/bloc.dart';
import 'package:distribucion_app/core/share_preferences/preferences.dart';
import 'package:distribucion_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeType themeType;
  ThemeCubit(this.themeType) : super(getThemeFromType(themeType));

  void changeTheme(ThemeType themeType) {
    Preferences.themeType = themeType;
    emit(getThemeFromType(themeType));
  }
}

ThemeState getThemeFromType(ThemeType themeType) {
  switch (themeType) {
    case ThemeType.light:
      return ThemeLight();
    case ThemeType.dark:
      return ThemeDark();
    case ThemeType.blue:
      return ThemeBlue();
  }
}
