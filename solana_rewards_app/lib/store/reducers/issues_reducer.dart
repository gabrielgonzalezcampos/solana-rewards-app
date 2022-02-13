
import 'package:redux/redux.dart';
import 'package:solana_rewards_app/store/actions/current_page_action.dart';
import 'package:solana_rewards_app/store/actions/issue_action.dart';
import 'package:solana_rewards_app/store/states/current_page_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';

final IssuesReducer = combineReducers<IssuesState>([
  TypedReducer<IssuesState, SetIssuesAction>(SetIssuesAction.setIssues),
  TypedReducer<IssuesState, AddIssuesAction>(AddIssuesAction.addIssues),
  TypedReducer<IssuesState, GetIssuesAction>(GetIssuesAction.getIssues),
  TypedReducer<IssuesState, SetTotalReward>(SetTotalReward.setTotalReward),
]);