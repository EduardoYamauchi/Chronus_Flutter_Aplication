import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/app_state.dart';
import 'package:chronus/presentation/menu_bar.dart';
import 'package:chronus/selectors/selectors.dart';

class MenuBarContainer extends StatelessWidget {
  MenuBarContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return MenuBar(
            getHourglassesDataAction: vm.getHourglassesDataAction,
            getTasksDataAction: vm.getTasksDataAction,
            getUserDataAction: vm.getUserDataAction);
      },
    );
  }
}

class _ViewModel {
  final Function getHourglassesDataAction;
  final Function getTasksDataAction;
  final Function getUserDataAction;

  _ViewModel(
      {@required this.getHourglassesDataAction,
      @required this.getTasksDataAction,
      @required this.getUserDataAction});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        getHourglassesDataAction: () => store
            .dispatch(GetHourglassesDataAction(userIdSelector(store.state))),
        getTasksDataAction: () =>
            store.dispatch(GetTasksDataAction(userIdSelector(store.state))),
        getUserDataAction: () =>
            store.dispatch(GetUserDataAction(userIdSelector(store.state))));
  }
}
