import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'package:chronus/actions/actions.dart';
import 'package:chronus/models/app_state.dart';
import 'package:chronus/models/hourglass.dart';
import 'package:chronus/models/hourglass_entity.dart';
import 'package:chronus/models/task.dart';
import 'package:chronus/models/task_entity.dart';
import 'package:chronus/models/user_data.dart';

Firestore firestore = Firestore.instance;

final allEpics = combineEpics<AppState>([
  _getUserDataStream,
  _hourglassesStream,
  _tasksStream,
  _addHourglass,
  _addTask,
  _addUserDataBeforeLogin
]);

Stream<dynamic> _hourglassesStream(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return Observable(actions)
      .ofType(TypeToken<GetHourglassesDataAction>())
      .switchMap((GetHourglassesDataAction requestAction) {
    return _getHourglassesObservable(requestAction.userId)
        .map((hourglass) => LoadHourglassesHistoryAction(
            hourglass.map(Hourglass.fromEntity).toList()))
        .takeUntil(actions.where((action) => action is CancelHourglassStream));
  });
}

Observable<List<HourglassEntity>> _getHourglassesObservable(String userId) {
  return Observable(firestore
      .collection('users')
      .document(userId)
      .collection('hourglassLogs')
      .snapshots()
      .map((snapshot) {
    return snapshot.documents.map((doc) {
      return HourglassEntity(
        doc['completedTime'],
        doc['projectName'],
        doc['userId'],
      );
    }).toList();
  }));
}

Stream<dynamic> _getUserDataStream(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return Observable(actions)
      .ofType(TypeToken<GetUserDataAction>())
      .switchMap((GetUserDataAction requestAction) {
    return getUserDataObservable(requestAction.userId)
        .map((userData) => LoadUserDataAction(userData))
        .takeUntil(
            actions.where((action) => action is CancelUserDataActionStream));
  });
}

Observable<UserData> getUserDataObservable(String userId) {
  return Observable(Firestore.instance
      .collection("users")
      .document(userId)
      .snapshots()
      .map((doc) {
    return UserData(
        doc['actualProject'],
        doc['lastDayWorked'],
        doc['userId'],
        doc['userName'],
        doc['completedHourglasses'],
        doc['totalDaysWorked'],
        doc['totalHourglassCompletedToday']);
  }));
}

Stream<dynamic> _tasksStream(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return Observable(actions)
      .ofType(TypeToken<GetTasksDataAction>())
      .switchMap((GetTasksDataAction requestAction) {
    return _getTasksObservable(requestAction.userId)
        .map((task) => LoadTasksAction(task.map(Task.fromEntity).toList()))
        .takeUntil(actions.where((action) => action is CancelTasksStream));
  });
}

Observable<List<TaskEntity>> _getTasksObservable(String userId) {
  return Observable(firestore
      .collection('users')
      .document(userId)
      .collection('tasks')
      .snapshots()
      .map((snapshot) {
    return snapshot.documents.map((doc) {
      return TaskEntity(
        doc['taskName'],
        doc['taskDescription'],
        doc['userId'],
      );
    }).toList();
  }));
}

Stream<dynamic> _addHourglass(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return Observable(actions)
      .ofType(TypeToken<AddHourglassAction>())
      .switchMap((AddHourglassAction addHourglassAction) {
    final itemsDocument = Firestore.instance
        .collection('users')
        .document(addHourglassAction.hourglass.userId)
        .collection('hourglassLogs')
        .document(addHourglassAction.hourglass.completedTime);
    final hourglass = addHourglassAction.hourglass;
    final addHourglass =
        (itemsDocument.setData((hourglass.toEntity().toJson())));
    return Stream.fromFuture(addHourglass);
  });
}

Stream<dynamic> _addTask(Stream<dynamic> actions, EpicStore<AppState> store) {
  return Observable(actions)
      .ofType(TypeToken<AddTaskAction>())
      .switchMap((AddTaskAction addTaskAction) {
    final itemsDocument = Firestore.instance
        .collection('users')
        .document(addTaskAction.task.userId)
        .collection('tasks')
        .document(addTaskAction.task.taskName);
    final task = addTaskAction.task;
    final addTask =
        (itemsDocument.setData((task.toEntity().firstRegisterToJson())));
    return Stream.fromFuture(addTask);
  });
}

Stream<dynamic> _addUserDataBeforeLogin(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return Observable(actions)
      .ofType(TypeToken<AddUserDataBeforeLoginAction>())
      .switchMap((AddUserDataBeforeLoginAction addUserDataBeforeLoginAction) {
    final itemsDocument = Firestore.instance
        .collection('users')
        .document(addUserDataBeforeLoginAction.user.uid);
    final user = addUserDataBeforeLoginAction.user;
    final addTask = (itemsDocument.setData({
      "userId": user.uid,
      "userName": user.displayName,
      "userPhotoUrl": user.photoUrl,
      "userEmail": user.email,
      "userProvideId": user.providerId
    }, merge: true));
    return Stream.fromFuture(addTask);
  });
}
