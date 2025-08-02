import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.light,
    fontFamily: 'Cairo',
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.teal,
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
  );
}