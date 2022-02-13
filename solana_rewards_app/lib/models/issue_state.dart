
enum IssueState {
  processing,
  uploaded,
  accepted,
  solving,
  solved,
  rejected,
  error
}


extension ParseToString on IssueState {
  String toShortString() {
    String res = toString().split('.').last;
    res = res[0].toUpperCase() + res.substring(1);
    return res;
  }
}

IssueState issueStateFromInt(int index) {
  if (index > IssueState.values.length) {
    throw RangeError.index(index, IssueState.values.length);
  }
  return IssueState.values[index];
}