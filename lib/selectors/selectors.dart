import 'package:chronus/models/app_state.dart';
import 'package:chronus/models/hourglass.dart';
import 'package:chronus/models/task.dart';

List<Hourglass> hourglassesSelector(AppState state) => state.hourglasses;

String taskSelectedSelector(AppState state) => state.taskSelected;

List<Task> tasksSelector(AppState state) => state.tasks;

String timeStampSelector(AppState state) => state.timeStamp;

String userIdSelector(AppState state) => state.currentUser.uid;



