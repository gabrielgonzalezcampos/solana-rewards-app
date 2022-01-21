import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/pages/create_issue/create_issue.dart';
import 'package:solana_rewards_app/pages/issue%20detail/issue_detail.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class IssuesList extends StatefulWidget {
  const IssuesList({Key? key}) : super(key: key);

  @override
  _IssuesListState createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  List<IssueElementModel> issues = [
    IssueElementModel(IssueType.thrash, "Issue 1", IssueState.accepted, ""),
    IssueElementModel(IssueType.thrash, "Issue 2", IssueState.solving, "tedst"),
    IssueElementModel(IssueType.thrash, "Issue 3", IssueState.solved, "",
        reward: 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            style: ButtonStyle(backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return Theme.of(context).primaryColor;
            })),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateIssue()),
              );
            },
            child: const Text('Add issue')),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: DataTable(
              showCheckboxColumn: false,
              headingRowHeight: 0,
              columns: _buildTableHeaders(),
              rows: _buildTableData()),
        ),
      ],
    );
  }

  List<DataColumn> _buildTableHeaders() {
    return [
      DataColumn(label: Container()),
      DataColumn(label: Container()),
      DataColumn(label: Container()),
    ];
  }

  List<DataRow> _buildTableData() {
    List<DataRow> dataRows = [];
    issues.forEach((element) => dataRows.add(_buildElement(element)));
    return dataRows;
  }

  DataRow _buildElement(IssueElementModel issue) {
    List<DataCell> children = [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(buildIcon(issue.type), size: 20),
            ),
            Text(issue.name, textAlign: TextAlign.left, textScaleFactor: 1.5),
          ],
        ),
      ),
      DataCell(Text(issue.state.toShortString(), textAlign: TextAlign.left)),
      DataCell(Text(issue.rewardToString()))
    ];

    return DataRow(
        cells: children,
        onSelectChanged: (bool? selected) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IssueDetail(issue: issue)),
              )
            });
  }
}
