
import 'package:redux/redux.dart';
import 'package:solana_rewards_app/store/actions/theme_action.dart';
import 'package:solana_rewards_app/store/models/theme_model.dart';

final ThemeReducer = combineReducers<ThemeModel>([
  TypedReducer<ThemeModel, ThemeAction>(ThemeAction.setTheme),
]);