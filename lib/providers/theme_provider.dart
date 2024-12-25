import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preferences/preferences.dart';
import 'package:riverpod_scalable_app/core/themes/app_theme.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeData>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeData> {
  @override
  ThemeData build() {
    return AppTheme.lightTheme;
  }

  void loadSavedValue() {
    state = ref.read(preferencesProvider).isDarkMode
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;
  }

  void setThemeData(ThemeData themeData) {
    state = themeData;
    ref.read(preferencesProvider).isDarkMode =
        themeData.brightness == Brightness.dark;

  }
}
