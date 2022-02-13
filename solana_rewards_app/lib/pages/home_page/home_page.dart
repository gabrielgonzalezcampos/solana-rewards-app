import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:solana_rewards_app/helpers/common.dart';
import 'package:solana_rewards_app/models/issue_state.dart';
import 'package:solana_rewards_app/models/issue_type.dart';
import 'package:solana_rewards_app/pages/issues_list/issues_list.dart';
import 'package:solana_rewards_app/store/actions/issue_action.dart';
import 'package:solana_rewards_app/store/actions/wallet_action.dart';
import 'package:solana_rewards_app/store/models/wallet_models.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element.dart';
import 'package:solana_rewards_app/widgets/issue_element/issue_element_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool creatingWallet = false;
  late WalletState walletState;
  late Store appStore;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: StoreConnector<AppState, WalletState>(
          distinct: true,
          converter: (store) {
            if (store.state.walletState.creationState == WalletCreationState.notCreated) {
              store.dispatch(InitWalletAction());
            }
            appStore = store;
            walletState = store.state.walletState;
            return store.state.walletState;
          },
          builder: (context, vm) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => _afterBuild(context));
            return const IssuesList();
          })
      ),
    );
  }

  _afterBuild(BuildContext context){
    print("AFTER");
    switch (walletState.creationState) {
      case WalletCreationState.notCreated:
        showToast(context, 'Creating Wallet');
        creatingWallet = true;
        break;
      case WalletCreationState.creating:
        creatingWallet = true;
        break;
      case WalletCreationState.created:
        if (creatingWallet) {
          showToast(context, 'Wallet created');
          print("created");
          creatingWallet = false;
          appStore.dispatch(GetIssuesAction());
        }
        break;
    }
  }
}
