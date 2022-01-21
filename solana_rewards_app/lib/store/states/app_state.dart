import 'package:flutter/material.dart';
import 'package:solana_rewards_app/store/reducers/theme_reducer.dart';

import '../models/theme_model.dart';

class AppState {
  ThemeModel themeState;

  AppState({required this.themeState});

  static AppState initialState() {
    return AppState(themeState: ThemeModel(themeData: ThemeData.dark()));
  }
}