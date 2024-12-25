import 'package:shared_preferences/shared_preferences.dart';

const String _keyIsDarkMode = 'is_dark_mode';

class Preferences {
  final SharedPreferences sharedPreferences;
  const Preferences(this.sharedPreferences);

  bool get isDarkMode => sharedPreferences.getBool(_keyIsDarkMode) ?? false;

  set isDarkMode(bool value) {
    sharedPreferences.setBool(_keyIsDarkMode, value);
  }
}