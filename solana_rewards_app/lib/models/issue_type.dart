import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum IssueType {
  thrash,
  road
}

extension ParseToString on IssueType {
  String toText() {
    String res = toString().split('.').last;
    res = res[0].toUpperCase() + res.substring(1);
    return res;
  }
}

IconData buildIcon(IssueType type) {
  switch (type) {
    case IssueType.thrash:
      return Icons.delete;

    default: return Icons.alarm;
  }
}

IssueType issueTypeFromInt(int index) {
  if (index > IssueType.values.length) {
    throw RangeError.index(index, IssueType.values.length);
  }
  return IssueType.values[index];
}

