import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(0xffA0E7E5),
    highlightColor: Colors.black,
    cardColor: Colors.white,
    focusColor: Color(0xffA0E7E5));

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.black,
    highlightColor: Colors.white,
    cardColor: Colors.black,
    focusColor: Colors.white);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _pref;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _pref.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _darkTheme);
  }
}
