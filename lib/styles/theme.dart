import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF95C5D4), //blue
  appBarTheme: const AppBarTheme(color: Color(0xFFB7DAE4)), //sky blue
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFE6ECF2), //light blue
    primary: const Color(0xFFE6ECF2), //light blue
    brightness: Brightness.light,
    surface: Colors.white,
    secondary: const Color(0xFFB7DAE4), //sky blue
    tertiary: const Color(0xFF95C5D4), //blue
    onSurface: const Color(0xFF606060), //black3
  ),
);

