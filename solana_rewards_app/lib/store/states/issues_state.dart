
import 'package:solana_rewards_app/models/issue.dart';

class IssuesState {
  List<Issue> issuesLists = [];
  int? reward;
  bool loading = false;
  bool error = false;
  int? accountBalance;

  IssuesState(this.issuesLists, {this.loading = false, this.error = false, this.reward, this.accountBalance});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssuesState &&
          runtimeType == other.runtimeType &&
          issuesLists == other.issuesLists &&
          reward == other.reward &&
          loading == other.loading &&
          error == other.error &&
          accountBalance == other.accountBalance;

  @override
  int get hashCode =>
      issuesLists.hashCode ^
      reward.hashCode ^
      loading.hashCode ^
      error.hashCode ^
      accountBalance.hashCode;
}