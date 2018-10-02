import 'package:redux/redux.dart';

import 'package:chronus/actions/actions.dart';

final taskSelectedReducer = combineReducers<String>([
  TypedReducer<String, SelectTaskAction>(_setLoadedTasks),
]);

String _setLoadedTasks(String hourglasses, SelectTaskAction action) {
  return action.taskName;
}
