import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:chronus/models/app_state.dart';
import 'package:chronus/presentation/task_selected.dart';

class TaskSelectedContainer extends StatelessWidget {
  TaskSelectedContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return TaskSelected(taskSelected: vm.taskSelected);
      },
    );
  }
}

class _ViewModel {
  final String taskSelected;
  _ViewModel({this.taskSelected});
  static _ViewModel fromStore(Store<AppState> store) {
    return  _ViewModel(
      taskSelected: store.state.taskSelected,
    );
  }
}
