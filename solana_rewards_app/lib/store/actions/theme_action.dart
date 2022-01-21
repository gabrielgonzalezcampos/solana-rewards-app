import 'package:flutter/material.dart';

import '../models/theme_model.dart';

class SetThemeDataAction {
  ThemeData themeData;

  SetThemeDataAction({required this.themeData}) : super();


  static ThemeModel setTheme(ThemeModel theme, SetThemeDataAction action) {
    theme.themeData = action.themeData;
    return theme;
  }
}