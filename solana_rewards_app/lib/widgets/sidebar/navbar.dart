
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';
import 'package:solana_rewards_app/store/states/issues_state.dart';
import 'package:solana_rewards_app/store/states/wallet_state.dart';
import 'package:solana_rewards_app/widgets/sidebar/sidebar_user_info.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  NetworkImage image = NetworkImage('https://thecoinshark.net/uploads/750x500/2021/10/solana-hits-new-all-time-high,-overtaking-ripple-s-capitalization.jpg');

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StoreConnector<AppState, WalletState>(
      distinct: true,
      converter: (store) {
        return store.state.walletState;
      },
      builder: (c, vm) {
        return Column(
          children: [
            _buildUserInfo(vm),
            StoreConnector<AppState, IssuesState>(
              distinct: true,
              converter: (store) {
                return store.state.issuesState;
              },
              builder: (context, issuesSate) {
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      if (issuesSate.accountBalance != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Account balance: ${issuesSate.accountBalance}"),
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Initializing Account..."),
                        )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    ));
  }

  UserInfo _buildUserInfo(WalletState walletState) {
    if (walletState.wallet == null) {
      return UserInfo(
          address: 'Initializing wallet...',
          mail: "Initializing account...",
          image: image);
    } else {
      if (walletState.account == null) {
        return UserInfo(
            address: walletState.wallet!.address,
            mail: "Initializing account...",
            image: image);
      }
      return UserInfo(
          address: walletState.wallet!.address,
          mail: walletState.account!.address,
          image: image);
    }
  }
}

/*Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(singleton.wallet.address,
            style: TextStyle(
                fontSize: 10.0
            ),),
          accountEmail: Text('example@gmail.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.black,
            child: ClipOval(
              child: Icon(Icons.person, size: 50.0),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('http://images.hdqwalls.com/wallpapers/flutter-logo-4k-qn.jpg')
            ),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 15,
            itemBuilder: (context, i) {

              return _buildRow();
            }
        )
      ],
    ),
  );
}*/
