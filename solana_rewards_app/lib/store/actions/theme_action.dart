import 'package:flutter/material.dart';

import '../models/theme_model.dart';

class ThemeAction {
  ThemeData themeData;

  ThemeAction({required this.themeData}) : super();


  static ThemeModel setTheme(ThemeModel theme, ThemeAction action) {
    theme.themeData = action.themeData;
    return theme;
  }
}