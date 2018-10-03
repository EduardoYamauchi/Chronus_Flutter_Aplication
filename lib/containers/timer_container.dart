import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:chronus/models/app_state.dart';
import 'package:chronus/models/hourglass.dart';
import 'package:chronus/models/user_data.dart';
import 'package:chronus/actions/actions.dart';
import 'package:chronus/selectors/selectors.dart';

import 'package:chronus/presentation/timer_screen.dart';

class TimerContainer extends StatelessWidget {
  TimerContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return TimerScreen(
          addHourglassAction: vm.addHourglassAction,
          setTimeStampAction: vm.setTimeStampAction,
          userData: vm.userData,
        );
      },
    );
  }
}

class _ViewModel {
  final Function addHourglassAction;
  final Function setTimeStampAction;
  final UserData userData;

  _ViewModel({
    this.addHourglassAction,
    this.setTimeStampAction,
    this.userData
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      addHourglassAction: () => store.dispatch(AddHourglassAction(Hourglass(
          timeStampSelector(store.state),
          taskSelectedSelector(store.state),
          userIdSelector(store.state)))),
      setTimeStampAction: () => store.dispatch(SetTimeStampAction()),
      userData: userDataSelector(store.state),
    );
  }
}
