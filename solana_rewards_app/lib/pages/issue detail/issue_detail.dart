import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solana_rewards_app/models/issue.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/widgets/attachments/attachments.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class IssueDetail extends StatelessWidget {
  IssueDetail({Key? key, required this.issue}) : super(key: key);

  Issue issue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text(issue.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Type: " + issue.issueType.toText(), textScaleFactor: 1.4),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("State: " + issue.state.toShortString(), textScaleFactor: 1.4),
                          ),
                          if (issue.description != "") Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(issue.description, textScaleFactor: 1.4),
                          ),
                          if (issue.reward != null) Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Reward: " + issue.rewardToString(), textScaleFactor: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text("Attachments", textScaleFactor: 2,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24, top: 8.0),
                    child: Attachments(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
