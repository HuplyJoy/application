import 'package:flutter/material.dart';

const kcolor = Colors.teal;

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: kcolor,
    brightness: Brightness.light,
    fontFamily: 'Cairo',
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: kcolor,
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
  );
}