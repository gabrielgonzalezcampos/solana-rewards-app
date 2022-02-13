import 'dart:typed_data';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:borsh_annotation/src/struct_annotation.dart';
import 'package:solana_rewards_app/config/config.dart';
import 'package:solana_rewards_app/models/issue.dart';
import 'package:solana_rewards_app/models/issue_schema.dart';
import 'package:tuple/tuple.dart';

extension IOExt on ByteData {
  List<IssueSchema> issuesListFromBorsh(List<int> bytes, {int offset = 0}) {
    List<IssueSchema> issuesList = [];
    final int length = getUint32(offset, Endian.little);

    Tuple2<IssueSchema, int> tuple;
    for (int i = 0; i < length; i++) {
      tuple = IssueSchema.fromBorshWithOffset(bytes.sublist(offset + 4));
      issuesList.add(tuple.item1);
      offset = tuple.item2;
    }
    return issuesList;
  }
}

List<int> buildSaveRequest(IssueSchema issue) {
  int size = 0;

  //Build endpoint part
  size += saveIssueId.length;
  size += 4;
  final data = ByteData(size);
  int offset = 0;
  offset += data.writeString(offset, saveIssueId);

  //Build issue part
  addPadding(issue);
  print(issue.title);
  List<int> issueBuffer = issue.toBorsh();
  size = 0;
  size += issueBuffer.length * 1;
  size += 4;
  final issueData = ByteData(size);
  offset = 0;
  offset += issueData.writeDynamicArray<int>(Borsh.u8, offset, issueBuffer);

  //Concat two buffers
  return data.buffer.asUint8List() + issueData.buffer.asUint8List();
}

void addPadding(IssueSchema issue){
  issue.title = getStringWithPadding(data: issue.title, length: dummyStringLength);
  issue.description = getStringWithPadding(data: issue.description, length: dummyStringLength);
  issue.issueType = getStringWithPadding(data: issue.issueType, length: dummyStateLength);
  issue.state = getStringWithPadding(data: issue.state, length: dummyStateLength);
}

int getInitialSize() {
  IssueSchema dummyIssue = buildDummyIssue();
  int length = 0;
  int dummyLength = dummyIssue.toBorsh().length;
  for(int i = 0; i < issueListLength; i++) {
    length += dummyLength; //add length in bytes for a single issue
  }
  length += 4; //first bytes to store array length
  return length;
}

IssueSchema buildDummyIssue() {
  return IssueSchema(
      title: buildDummyString(),
      description: buildDummyString(),
      reward: 10,
      issueType: buildDummyString(length: dummyStateLength),
      state: buildDummyString(length: dummyStateLength),
      /*attachments: []*/);
}

String buildDummyString({int length = dummyStringLength}) {
  String res = "";
  for(int i = 0; i < length; i++){
    res += "0";
  }
  return res;
}

String getStringWithPadding({required String data, required int length}){
  int diff = length - data.length;
  if (diff<0){
    throw Exception("Message too long");
  }
  String padding = "";
  for (int i = 0; i < diff; i++){
    padding += "0";
  }
  String res = padding + data;
  print(res);
  return res;
}


String trimPadding(String message){
  return message.replaceAll(RegExp(r'^[0]{1,}'),'');
}
