import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:solana_rewards_app/models/issue.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/pages/create_issue/create_issue.dart';
import 'package:solana_rewards_app/pages/issue%20detail/issue_detail.dart';
import 'package:solana_rewards_app/store/actions/issue_action.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class IssuesList extends StatefulWidget {
  const IssuesList({Key? key}) : super(key: key);

  @override
  _IssuesListState createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  List<Issue> issues = [];

  late Store _store;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Issues", textScaleFactor: 2),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
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
                child: StoreConnector<AppState, IssuesState>(
                    distinct: true,
                    converter: (store) {
                      _store = store;
                      return store.state.issuesState;
                    },
                    builder: (context, issuesState) {
                      return Column(
                        children: [
                          if (issuesState.reward != null) Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Total reward: ${issuesState.reward}"),
                          ),
                          GestureDetector(
                            onVerticalDragDown: (details) {
                              print("Globalpos: ${details.globalPosition}, localPos: ${details.localPosition}");
                              _store.dispatch(GetIssuesAction());
                            },
                            child: DataTable(
                                showCheckboxColumn: false,
                                headingRowHeight: 0,
                                columns: _buildTableHeaders(),
                                rows: _buildTableData(issuesState.issuesLists)),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
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

  List<DataRow> _buildTableData(List<Issue> issues) {
    List<DataRow> dataRows = [];
    issues.forEach((element) => dataRows.add(_buildElement(element)));
    return dataRows;
  }

  DataRow _buildElement(Issue issue) {
    List<DataCell> children = [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(buildIcon(issue.issueType), size: 20),
            ),
            Text(issue.title, textAlign: TextAlign.left, textScaleFactor: 1.5),
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
