import 'package:firebase_auth/firebase_auth.dart';

import 'package:chronus/models/hourglass.dart';
import 'package:chronus/models/task.dart';
import 'package:chronus/models/user_data.dart';

class GetUserDataAction {
  final String userId;
  GetUserDataAction(this.userId);
  @override
  String toString() {
    return 'GetUserDataAction{taskName: $userId}';
  }
}

class LoadUserDataAction {
  final UserData userData;
  LoadUserDataAction(this.userData);
  @override
  String toString() {
    return 'LoadUserDataAction{hourglass: $userData}';
  }
}

class CancelUserDataActionStream {
  final String userId;
  CancelUserDataActionStream(this.userId);
  @override
  String toString() {
    return 'CancelUserDataAction{taskName: $userId}';
  }
}

class AddUserDataBeforeLoginAction {
  final FirebaseUser user;
  AddUserDataBeforeLoginAction({this.user});
  @override
  String toString() {
    return 'AddUserDataBeforeLoginAction{user: $user}';
  }
}

class GetHourglassesDataAction {
  final String userId;
  GetHourglassesDataAction(this.userId);
  @override
  String toString() {
    return 'GetHourglassesDataAction{userId: $userId}';
  }
}

class CancelHourglassStream {
  @override
  String toString() {
    return 'CancelHourglassStream{}';
  }
}

class LoadHourglassesHistoryAction {
  final List<Hourglass> hourglasses;
  LoadHourglassesHistoryAction(this.hourglasses);
  @override
  String toString() {
    return 'LoadHourglassesHistoryAction{hourglass: $hourglasses}';
  }
}

class AddHourglassAction {
  final Hourglass hourglass;
  AddHourglassAction(this.hourglass);
  @override
  String toString() {
    return 'AddHourglassAction{hourglass: $hourglass}';
  }
}

class GetTasksDataAction {
  final String userId;
  GetTasksDataAction(this.userId);
  @override
  String toString() {
    return 'GetTasksDataAction{userId: $userId}';
  }
}

class CancelTasksStream {
  @override
  String toString() {
    return 'CancelTasksStream{}';
  }
}

class LoadTasksAction {
  final List<Task> tasks;
  LoadTasksAction(this.tasks);
  @override
  String toString() {
    return 'LoadHourglassesHistoryAction{hourglass: $tasks}';
  }
}

class AddTaskAction {
  final Task task;
  AddTaskAction(this.task);
  @override
  String toString() {
    return 'AddTaskAction{AddTaskAction: $task}';
  }
}

class SelectTaskAction {
  final String taskName;
  SelectTaskAction(this.taskName);
  @override
  String toString() {
    return 'SelectTaskAction{taskName: $taskName}';
  }
}

class GoogleLogInAction {
  @override
  String toString() {
    return 'GoogleLogInAction';
  }
}

class GoogleLogInSuccessfulAction {
  final FirebaseUser user;
  GoogleLogInSuccessfulAction({this.user});
  @override
  String toString() {
    return 'GoogleLogInSuccessful{user: $user}';
  }
}

class GoogleLogInFailAction {
  final dynamic error;
  GoogleLogInFailAction(this.error);
  @override
  String toString() {
    return 'GoogleLogInFail{There was an error loggin in: $error}';
  }
}

class GoogleLogoutAction {
  @override
  String toString() {
    return 'GoogleLogoutAction';
  }
}

class GoogleLogoutSuccessfulAction {
  GoogleLogoutSuccessfulAction();
  @override
  String toString() {
    return 'GoogleLogoutSuccessfulAction';
  }
}

class NavigateToHomeAction {
  @override
  String toString() {
    return 'NavigateToHomeAction';
  }
}

class SetTimeStampAction {
  @override
  String toString() {
    return 'SetTimeStampAction{}';
  }
}
