// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_schema.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

Tuple2<IssueSchema,int> _IssueSchemaFromBorsh(List<int> _data, {int offset = 0}) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final title = _view.readString(offset);
  offset += 4 + title.length;

  final description = _view.readString(offset);
  offset += 4 + description.length;

  final reward = _view.readInteger(Borsh.u64, offset);
  offset += 8;

  final issueType = _view.readString(offset);
  offset += 4 + issueType.length;

  final state = _view.readString(offset);
  offset += 4 + state.length;


  return Tuple2(IssueSchema(
    title: title,
    description: description,
    reward: reward,
    issueType: issueType,
    state: state,
  ), offset);
}

List<int> _IssueSchemaToBorsh(IssueSchema s) {
  int size = 0;
  size += s.title.length;
  size += s.description.length;
  size += s.issueType.length;
  size += s.state.length;
  size += 24;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeString(offset, s.title);
  offset += data.writeString(offset, s.description);
  offset += data.writeInteger(Borsh.u64, offset, s.reward);
  offset += data.writeString(offset, s.issueType);
  offset += data.writeString(offset, s.state);

  return data.buffer.asUint8List();
}
