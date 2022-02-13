import 'package:flutter/material.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';

import '../models/theme_model.dart';
import 'current_page_state.dart';

class AppState {
  ThemeModel themeState;
  WalletState walletState;
  CurrentPageState currentPageState;
  IssuesState issuesState;

  static AppState initialState() {
    return AppState(
        themeState: ThemeModel(themeData: ThemeData.dark()),
        walletState: WalletState(),
        currentPageState: CurrentPageState(isLoggedUser: false),
        issuesState: IssuesState([])
    );
  }

  AppState({
    required this.themeState,
    required this.walletState,
    required this.currentPageState,
    required this.issuesState
  });
}