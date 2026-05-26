import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      primaryColor: const Color(0xFF7C3AED),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7C3AED),
        surface: Color(0xFF16213E),
      ),
      fontFamily: 'Roboto',
    );
  }

  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFEFF6FF),
      primaryColor: const Color(0xFF3B82F6),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF3B82F6),
        surface: Color(0xFFFFFFFF),
      ),
      fontFamily: 'Roboto',
    );
  }
}
