

import 'package:solana/solana.dart';
import 'package:solana_rewards_app/store/models/wallet_models.dart';

class WalletState {
  Wallet? wallet;
  SolanaClient? connection;
  WalletCreationState creationState;
  Ed25519HDKeyPair? account;
  int? accountBalance;

  WalletState({this.wallet, this.connection, this.creationState = WalletCreationState.notCreated, this.account, this.accountBalance});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletState &&
          runtimeType == other.runtimeType &&
          wallet == other.wallet &&
          connection == other.connection &&
          creationState == other.creationState &&
          account == other.account &&
          accountBalance == other.accountBalance;

  @override
  int get hashCode =>
      wallet.hashCode ^
      connection.hashCode ^
      creationState.hashCode ^
      account.hashCode ^
      accountBalance.hashCode;
}