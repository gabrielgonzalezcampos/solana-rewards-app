import 'package:solana_rewards_app/store/states/current_page_state.dart';

class SetCurrentPageAction {
  CurrentPageState currentPageState;

  SetCurrentPageAction({required this.currentPageState}) : super();


  static CurrentPageState setCurrentPage(CurrentPageState state, SetCurrentPageAction action) {
    state = action.currentPageState;
    return state;
  }
}