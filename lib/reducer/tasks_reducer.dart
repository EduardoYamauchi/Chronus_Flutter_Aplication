import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/task.dart';

final tasksReducer = combineReducers<List<Task>>([
  TypedReducer<List<Task>, LoadTasksAction>(_setLoadedTasks),
]);

List<Task> _setLoadedTasks(List<Task> hourglasses, LoadTasksAction action) {
  return action.tasks;
}
