import 'package:solana/solana.dart';
import 'package:solana_rewards_app/models/issue.dart';
import 'package:solana_rewards_app/store/states/current_page_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';

class SetIssuesAction {
  IssuesState issuesState;

  SetIssuesAction({required this.issuesState}) : super();


  static IssuesState setIssues(IssuesState state, SetIssuesAction action) {
    state = action.issuesState;
    return state;
  }
}

class AddIssuesAction {
  List<Issue> issues;

  AddIssuesAction({required this.issues}) : super();


  static IssuesState addIssues(IssuesState state, AddIssuesAction action) {
    state.issuesLists.addAll(action.issues);
    return state;
  }
}

class GetIssuesAction {

  GetIssuesAction() : super();


  static IssuesState getIssues(IssuesState state, GetIssuesAction action) {
    return state;
  }
}

class SubmitIssueAction {
  Issue issue;

  SubmitIssueAction({required this.issue}) : super();


  static IssuesState submitIssue(IssuesState state, SubmitIssueAction action) {
    state.loading = true;
    return state;
  }
}

class SetTotalReward {
  int reward;
  int? balance;

  SetTotalReward({required this.reward, this.balance}) : super();


  static IssuesState setTotalReward(IssuesState state, SetTotalReward action) {
    state.reward = action.reward;
    if (action.balance != null) {
      state.accountBalance = action.balance;
    }
    return state;
  }
}