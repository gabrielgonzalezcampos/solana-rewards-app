import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/pages/issues_list/issues_list.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text("Issues", textScaleFactor: 2),
          FractionallySizedBox(
              widthFactor: 0.9,
              child: IssuesList()
          ),
        ],
      )),
    );
  }
}
