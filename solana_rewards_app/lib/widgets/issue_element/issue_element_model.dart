
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';

class IssueElementModel {
  late IssueType type;
  late String name;
  late IssueState state;
  int? reward;
  late String description;

  IssueElementModel(this.type, this.name, this.state, this.description, {this.reward});


  String rewardToString() {
    if (reward == null) {
      return "";
    }
    if (reward! < 0) {
      return "-" + reward.toString();
    } else {
      return "+" + reward.toString();
    }
  }

  IssueElementModel.empty();
}