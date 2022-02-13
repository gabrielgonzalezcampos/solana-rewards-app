import 'dart:typed_data';
import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:borsh/borsh.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:tuple/tuple.dart';

import 'issue.dart';

part 'custom_issue_schema_generator.dart';
//part 'issue_schema.g.dart';

@Struct()
class IssueSchema extends BorshStruct {

  @string
  String title;
  @string
  String description;
  @u64
  int reward;
  @string
  String issueType;
  @string
  String state;
  /*@Array.dynamic(Borsh.string)
  List<String> attachments;*/

  factory IssueSchema.fromBorsh(List<int> bytes) => _IssueSchemaFromBorsh(bytes).item1;

  static fromBorshWithOffset(List<int> bytes) => _IssueSchemaFromBorsh(bytes);

  @override
  List<int> toBorsh() => _IssueSchemaToBorsh(this);

  IssueSchema({required this.title, required this.description, required this.reward, required this.issueType,
    required this.state/*, required this.attachments*/});

  factory IssueSchema.fromIssue(Issue issue){
    return IssueSchema(
        title: issue.title,
        description: issue.description,
        reward: issue.reward,
        issueType: issue.issueType.toText(),
        state: issue.state.toShortString(),
        /*attachments: issue.attachments*/
    );
  }
}