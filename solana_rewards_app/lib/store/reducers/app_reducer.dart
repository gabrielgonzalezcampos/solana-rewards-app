import 'package:solana_rewards_app/store/reducers/issues_reducer.dart';
import 'package:solana_rewards_app/store/reducers/theme_reducer.dart';
import 'package:solana_rewards_app/store/reducers/wallet_reducer.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';

import 'current_page_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      themeState: ThemeReducer(state.themeState, action),
      walletState: WalletReducer(state.walletState, action),
      currentPageState: CurrentPageReducer(state.currentPageState, action),
      issuesState: IssuesReducer(state.issuesState, action));
}
