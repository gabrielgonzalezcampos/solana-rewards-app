
import 'package:redux_saga/redux_saga.dart';
import 'package:solana_rewards_app/store/effects/issues_effects.dart';
import 'package:solana_rewards_app/store/effects/wallet_effects.dart';

rootSaga() sync* {
  yield All({
    #t1: Fork(initWalletEffect),
    #t2: Fork(IssuesEffects),
  });
}