import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class IssueElement extends StatelessWidget {
  IssueElement({Key? key, required this.issue}) : super(key: key);

  IssueElementModel issue;

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FractionallySizedBox(
          child: Container(
            color: Colors.red,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(buildIcon(issue.type), size: 20),
                ),
                Text(issue.name, textAlign: TextAlign.left, textScaleFactor: 1.5),
              ],
            ),
          )),
        Text(issue.state.toShortString(), textAlign: TextAlign.left),
        _getRewardAsText()
      ],
    );
  }

  Widget _getRewardAsText(){
    String text = "";
    if (issue.reward != null) {
      text = _rewardToString(issue.reward!);
    }
    return Container(
      child: Text(text),
      width: 32,
    );
  }

  String _rewardToString(int reward) {
    if (reward<0) {
      return "-" + reward.toString();
    } else {
      return "+" + reward.toString();
    }
  }
}
