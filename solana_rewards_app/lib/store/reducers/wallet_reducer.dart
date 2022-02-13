

import 'package:redux/redux.dart';
import 'package:solana_rewards_app/store/actions/wallet_action.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';

final WalletReducer = combineReducers<WalletState>([
  TypedReducer<WalletState, SetWalletAction>(SetWalletAction.setWallet),
  TypedReducer<WalletState, SetAccountBalance>(SetAccountBalance.setAccountBalance),
]);