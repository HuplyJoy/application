import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode>{
  ThemeModeNotifier():super(ThemeMode.dark);
  void changThemeMode(bool isDark){
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref){
  return ThemeModeNotifier();
});