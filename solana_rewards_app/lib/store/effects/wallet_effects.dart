
import 'package:redux_saga/redux_saga.dart';
import 'package:solana/solana.dart';
import 'package:solana_rewards_app/config/config.dart';
import 'package:solana_rewards_app/config/constants.dart';
import 'package:solana_rewards_app/helpers/wallet.dart';
import 'package:solana_rewards_app/services/mappers/issues_mapper.dart';
import 'package:solana_rewards_app/services/solana/accounts.dart';
import 'package:solana_rewards_app/store/actions/wallet_action.dart';
import 'package:solana_rewards_app/store/models/wallet_models.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';
import 'package:tuple/tuple.dart';

initWalletEffect() sync* {
  var walletState = Result<WalletState>();
  yield Call(createWallet, result: walletState);
  yield Put(SetWalletAction(walletState: walletState.value as WalletState));
}

Future<WalletState> createWallet() async {
  const newseed = seed;//randomSeed()
  int initialSize = getInitialSize();
  Tuple2<SolanaClient,Wallet> tuple = await initWalletFromSeed(newseed, size: 2*initialSize);
  Ed25519HDKeyPair account = await getChatMessageAccountPubKey(tuple.item1,tuple.item2, initialSize);
  return WalletState(wallet: tuple.item2, connection: tuple.item1, creationState: WalletCreationState.created, account: account);
}