import 'package:firebase_auth/firebase_auth.dart';

import 'package:chronus/models/hourglass.dart';
import 'package:chronus/models/task.dart';
import 'package:chronus/models/user_data.dart';

class AppState {
  final bool ifLoading;
  final FirebaseUser currentUser;
  final String taskSelected;
  final String timeStamp;
  final List<Hourglass> hourglasses;
  final List<Task> tasks;
  final UserData userData;

  AppState(
      {this.ifLoading = false,
      this.currentUser,
      this.taskSelected = "No task selected",
      this.timeStamp = "",
      this.hourglasses = const [],
      this.tasks = const [],
      this.userData});

  AppState copyWith(
      {bool ifLoading,
      FirebaseUser currentUser,
      String taskSelected,
      String timeStamp,
      List<Hourglass> hourglasses,
      List<Task> tasks,
      UserData userData}) {
    return  AppState(
        ifLoading: ifLoading ?? this.ifLoading,
        currentUser: currentUser ?? this.currentUser,
        taskSelected: taskSelected ?? this.taskSelected,
        timeStamp: timeStamp ?? this.timeStamp,
        hourglasses: hourglasses ?? this.hourglasses,
        tasks: tasks ?? this.tasks,
        userData: userData ?? this.userData);
  }

  @override
  int get hashCode =>
      ifLoading.hashCode ^
      currentUser.hashCode ^
      taskSelected.hashCode ^
      timeStamp.hashCode ^
      hourglasses.hashCode ^
      tasks.hashCode ^
      userData.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          ifLoading == other.ifLoading &&
          currentUser == other.currentUser &&
          taskSelected == other.taskSelected &&
          timeStamp == other.timeStamp &&
          hourglasses == other.hourglasses &&
          tasks == other.tasks &&
          userData == other.userData;

  @override
  String toString() {
    return 'AppState{ifLoading: $ifLoading,\n'
        'currentUser: $currentUser,\n'
        'taskSelected: $taskSelected,\n'
        'timeStamp: $timeStamp,\n'
        'tasks: $tasks,\n'
        'userData: $userData}';
  }
}
