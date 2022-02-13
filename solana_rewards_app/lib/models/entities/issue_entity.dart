import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:borsh/borsh.dart';
import 'dart:typed_data';

part 'issue_entity.g.dart';

@Struct()
class IssueEntity extends BorshStruct {
  @string
  String title;
  @string
  String description;
  @i64
  int reward;
  @i8
  int issue_type;
  @i8
  int state;
  @Array.dynamic(Borsh.string)
  List<String> attachments;

  IssueEntity({required this.title, required this.description, required this.reward, required this.issue_type,
      required this.state, required this.attachments});

  factory IssueEntity.fromBorsh(List<int> bytes) => _IssueEntityFromBorsh(bytes);

  @override
  List<int> toBorsh() => _IssueEntityToBorsh(this);
}