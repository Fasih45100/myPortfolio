import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  // Custom color palette
  static const Color _primaryLight = Colors.blue;
  static const Color _primaryDark = Colors.lightBlue;
  static const Color _secondaryLight = Colors.orange;
  static const Color _secondaryDark = Colors.deepOrange;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData {
    return _isDarkMode ? _buildDarkTheme() : _buildLightTheme();
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: _primaryLight,
        secondary: _secondaryLight,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        color: _primaryLight,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryLight,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: _primaryDark,
        secondary: _secondaryDark,
        surface: Colors.grey[900]!,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.grey[850],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryDark,
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.grey[850],
      ),
    );
  }

  Future<void> toggleTheme() async {
    // Optional: Add animation delay for smoother transition
    await Future.delayed(const Duration(milliseconds: 100));
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Optional: System theme detection
  Future<void> syncWithSystem() async {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
    notifyListeners();
  }
}
