import 'package:solana_rewards_app/models/entities/issue_entity.dart';
import 'package:solana_rewards_app/models/issue_schema.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/services/mappers/issues_mapper.dart';

class Issue {
  String title;
  String description;
  int reward;
  IssueType issueType;
  IssueState state;
  List<String> attachments;

  Issue(
      {required this.title,
      required this.description,
      required this.reward,
      required this.issueType,
      required this.state,
      required this.attachments});

  factory Issue.fromEntity(IssueEntity entity) => Issue(
      title: entity.title,
      description: entity.description,
      reward: entity.reward,
      issueType: issueTypeFromInt(entity.issue_type),
      state: issueStateFromInt(entity.state),
      attachments: entity.attachments);

  factory Issue.fromSchema(IssueSchema entity) {
    return Issue(
        title: trimPadding(entity.title),
        description: trimPadding(entity.description),
        reward: entity.reward,
        issueType: IssueType.values.firstWhere(
            (e) => e.toString().contains(trimPadding(entity.issueType).toLowerCase())),
        state: IssueState.values.firstWhere(
            (e) => e.toString().contains(trimPadding(entity.state).toLowerCase())),
        attachments: []/*entity.attachments*/);
  }

  String rewardToString() {
    if (reward == 0) {
      return "Not accepted yet";
    }
    if (reward < 0) {
      return "-" + reward.toString();
    } else {
      return "+" + reward.toString();
    }
  }
}
