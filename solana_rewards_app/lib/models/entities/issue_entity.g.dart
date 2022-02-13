// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_entity.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

IssueEntity _IssueEntityFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final title = _view.readString(offset);
  offset += 4 + title.length;

  final description = _view.readString(offset);
  offset += 4 + description.length;

  final reward = _view.readInteger(Borsh.i64, offset);
  offset += 8;

  final issue_type = _view.readInteger(Borsh.i8, offset);
  offset += 1;

  final state = _view.readInteger(Borsh.i8, offset);
  offset += 1;

  final attachments = _view.readDynamicArray<String>(Borsh.string, offset);
  offset += 4 + attachments.fold(0, (t, i) => t + i.length + 4);

  return IssueEntity(
    title: title,
    description: description,
    reward: reward,
    issue_type: issue_type,
    state: state,
    attachments: attachments,
  );
}

List<int> _IssueEntityToBorsh(IssueEntity s) {
  int size = 0;
  size += s.title.length;
  size += s.description.length;
  size += s.attachments.fold(0, (t, i) => t + i.length + 4);
  size += 22;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeString(offset, s.title);
  offset += data.writeString(offset, s.description);
  offset += data.writeInteger(Borsh.i64, offset, s.reward);
  offset += data.writeInteger(Borsh.i8, offset, s.issue_type);
  offset += data.writeInteger(Borsh.i8, offset, s.state);
  offset += data.writeDynamicArray<String>(Borsh.string, offset, s.attachments);

  return data.buffer.asUint8List();
}
