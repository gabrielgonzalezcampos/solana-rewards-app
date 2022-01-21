
import 'package:solana_rewards_app/store/reducers/theme_reducer.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(themeState: ThemeReducer(state.themeState, action));
}