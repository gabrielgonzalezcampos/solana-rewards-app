
import 'package:redux/redux.dart';
import 'package:solana_rewards_app/store/actions/current_page_action.dart';
import 'package:solana_rewards_app/store/states/current_page_state.dart';

final CurrentPageReducer = combineReducers<CurrentPageState>([
  TypedReducer<CurrentPageState, SetCurrentPageAction>(SetCurrentPageAction.setCurrentPage),
]);