
import 'package:solana/solana.dart';
import 'package:solana_rewards_app/helpers/wallet.dart';
import 'package:solana_rewards_app/store/models/wallet_models.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';
import 'package:tuple/tuple.dart';

class SetWalletAction {
  WalletState walletState;

  SetWalletAction({required this.walletState}) : super();


  static WalletState setWallet(WalletState state, SetWalletAction action) {
    state = action.walletState;
    return state;
  }
}

class InitWalletAction {
  bool isRandom;
  List<int>? seed;

  InitWalletAction({this.isRandom = true, this.seed}) : super();


  static WalletState initWallet(WalletState state, InitWalletAction action) {
    state.creationState = WalletCreationState.creating;
    return state;
  }
}

class SetAccountBalance {
  int balance;

  SetAccountBalance({required this.balance}) : super();

  static WalletState setAccountBalance(WalletState state, SetAccountBalance action) {
    print("balance");
    state.accountBalance = action.balance;
    return state;
  }
}