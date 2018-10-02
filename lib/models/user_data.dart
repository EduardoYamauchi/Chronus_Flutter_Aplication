import 'package:meta/meta.dart';

@immutable
class UserData {
  final String actualProject;
  final String lastDayWorked;
  final String userId;
  final String userName;
  final int completedHourglasses;
  final int totalDaysWorked;
  final int totalHourglassCompletedToday;

  UserData(
      this.actualProject,
      this.lastDayWorked,
      this.userId,
      this.userName,
      this.completedHourglasses,
      this.totalDaysWorked,
      this.totalHourglassCompletedToday);

  UserData copyWith(
      {String actualProject,
      String lastDayWorked,
      String userId,
      String userName,
      int completedHourglasses,
      int totalDaysWorked,
      int totalHourglassCompletedToday}) {
    return UserData(
        actualProject ?? this.actualProject,
        lastDayWorked ?? this.lastDayWorked,
        userId ?? this.userId,
        userName ?? this.userName,
        completedHourglasses ?? this.completedHourglasses,
        totalDaysWorked ?? this.totalDaysWorked,
        totalHourglassCompletedToday ?? this.totalHourglassCompletedToday);
  }

  @override
  int get hashCode =>
      actualProject.hashCode ^
      lastDayWorked.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      completedHourglasses.hashCode ^
      totalDaysWorked.hashCode ^
      totalHourglassCompletedToday.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserData &&
          runtimeType == other.runtimeType &&
          actualProject == other.actualProject &&
          lastDayWorked == other.lastDayWorked &&
          userId == other.userId &&
          userName == other.userName &&
          completedHourglasses == other.completedHourglasses &&
          totalDaysWorked == other.totalDaysWorked &&
          totalHourglassCompletedToday == other.totalHourglassCompletedToday;

  @override
  String toString() {
    return 'UserData{actualProject: $actualProject,\n'
        'lastDayWorked: $lastDayWorked,\n'
        'userId: $userId,\n'
        'userName: $userName,\n'
        'completedHourglasses: $completedHourglasses,\n'
        'totalDaysWorked: $totalDaysWorked,\n'
        'totalHourglassCompletedToday: $totalHourglassCompletedToday}';
  }
}
