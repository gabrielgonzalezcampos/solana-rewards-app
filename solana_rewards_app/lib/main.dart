import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:solana_rewards_app/pages/home_page/home_page.dart';
import 'package:solana_rewards_app/store/reducers/app_reducer.dart';
import 'package:solana_rewards_app/store/states/app_state.dart';
import 'package:redux/redux.dart';

void main() {
  //final store = Store<AppState>(appReducer, initialState: AppState.initialState());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Color(0xFF8F00FF)
        ),
        splashColor: Color(0xFF715BAF),
        brightness: Brightness.dark,
        primaryColor: Color(0xFF8F00FF),
      ),
      home: Scaffold(
        appBar: AppBar (
          title: const Text("Rewards"),
        ),
        body:  const HomePage(),
      ),
    );
  }
}
