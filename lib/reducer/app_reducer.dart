import 'package:chronus/reducer/auth_reducer.dart';
import 'package:chronus/reducer/hourglasses_reducer.dart';
import 'package:chronus/reducer/tasks_reducer.dart';
import 'package:chronus/reducer/task_selected_reducer.dart';
import 'package:chronus/reducer/time_stamp_reducer.dart';
import 'package:chronus/reducer/user_data_reducer.dart';
import 'package:chronus/models/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      ifLoading: false,
      currentUser: authReducer(state.currentUser, action),
      timeStamp: timeStampReducer(state.timeStamp, action),
      hourglasses: hourglassesReducer(state.hourglasses, action),
      tasks: tasksReducer(state.tasks, action),
      taskSelected: taskSelectedReducer(state.taskSelected, action),
      userData: userDataReducer(state.userData, action));
}


