
import 'package:redux_saga/redux_saga.dart';
import 'package:solana/solana.dart';
import 'package:solana_rewards_app/config/config.dart';
import 'package:solana_rewards_app/config/constants.dart';
import 'package:solana_rewards_app/helpers/wallet.dart';
import 'package:solana_rewards_app/models/issue.dart';
import 'package:solana_rewards_app/services/solana/accounts.dart';
import 'package:solana_rewards_app/services/solana/action_service.dart';
import 'package:solana_rewards_app/store/actions/issue_action.dart';
import 'package:solana_rewards_app/store/actions/wallet_action.dart';
import 'package:solana_rewards_app/store/models/wallet_models.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';
import 'package:tuple/tuple.dart';


IssuesEffects() sync* {
  yield TakeEvery(getIssuesEffect, pattern: GetIssuesAction);
  yield TakeEvery(submitIssueEffect, pattern: SubmitIssueAction);
  //yield TakeEvery(setTotalReward, pattern: SetIssuesAction);
}

getIssuesEffect({dynamic action}) sync* {
  var issuesState = Result<IssuesState>();
  var appState = Result<AppState>();
  yield Select(result: appState);
  yield Call(_getIssues, result: issuesState, args: [appState.value]);
  yield Put(SetIssuesAction(issuesState: issuesState.value!));
}

Future<IssuesState> _getIssues(AppState appState) async {

  if(appState.walletState.connection != null){
    Tuple3<List<Issue>,int, int> tuple = await ActionService.getAccountMessageHistory(appState.walletState.connection!, appState.walletState.account!.address); //Tuple3(issuesList, sentAccount.lamports, reward)
    List<Issue> issuesList = tuple.item1;
    int balance = tuple.item2;
    int reward = tuple.item3;
    return IssuesState(issuesList, reward: reward, accountBalance: balance);
  }

  return IssuesState([]);
}

submitIssueEffect({dynamic action}) sync* {
  var appState = Result<AppState>();
  yield Select(result: appState);
  yield Call(_submitIssue,result: appState, args: [appState.value, action]);
  yield Put(SetIssuesAction(issuesState: appState.value!.issuesState));
  yield Put(GetIssuesAction());
}



Future<AppState> _submitIssue(AppState appState, SubmitIssueAction action) async {
  if(appState.walletState.connection != null){
    await ActionService.saveIssue(appState.walletState.connection!, appState.walletState.wallet!, appState.walletState.account!.address, action.issue);
    // try{
    //   await ActionService.sendMessage(appState.walletState.connection!, appState.walletState.wallet!, appState.walletState.account!.address, action.issue);
    // } catch (e) {
    //   appState.issuesState.error = true;
    // }
  }
  appState.issuesState.loading = false;
  return appState;
}
/*
setTotalReward({dynamic action}) sync* {
  var appState = Result<AppState>();
  yield Select(result: appState);
  if ()
  yield Call(_submitIssue,result: appState, args: [appState.value, action]);
  yield Put(SetTotalReward(reward: appState.value!.issuesState.reward!, balance: appState.value!.issuesState.accountBalance!));
}*/

WalletState getWallet(AppState state) => state.walletState;