import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/presentation/task_screen.dart';
import 'package:chronus/models/app_state.dart';
import 'package:chronus/models/task.dart';
import 'package:chronus/selectors/selectors.dart';

class TasksContainer extends StatelessWidget {
  TasksContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return TaskScreen(
            tasks: vm.tasks,
            count: vm.tasks.length,
            loading: vm.loading,
            selectTaskAction: vm.selectTaskAction,
            addTaskAction: vm.addTaskAction,
            taskSelected: vm.taskSelected);
      },
    );
  }
}

class _ViewModel {
  final List<Task> tasks;
  final bool loading;
  final Function selectTaskAction;
  final Function addTaskAction;
  final String taskSelected;

  _ViewModel(
      {@required this.tasks,
      @required this.loading,
      @required this.selectTaskAction,
      @required this.addTaskAction,
      @required this.taskSelected});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        tasks: tasksSelector(store.state),
        loading: store.state.ifLoading,
        selectTaskAction: (String taskName) =>
            store.dispatch(SelectTaskAction(taskName)),
        addTaskAction: (String project, String description) => store.dispatch(
            AddTaskAction(
                Task(project, description, userIdSelector(store.state)))),
        taskSelected: store.state.taskSelected);
  }
}
