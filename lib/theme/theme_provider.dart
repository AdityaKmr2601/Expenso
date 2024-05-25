import 'package:expenso/theme/dark_mode.dart';
import 'package:expenso/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData =
      (Hive.box("theme").get(1) == "lightMode") ? lightMode : darkMode;
  final mybox = Hive.box("theme");
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void check() {
    if (Hive.box("theme").values.isEmpty) {
      Hive.box("theme").put(1, "darkMode");
    }
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      mybox.put(1, "darkMode");
    } else {
      themeData = lightMode;
      mybox.put(1, "lightMode");
    }
  }

  void mono() {}
}
