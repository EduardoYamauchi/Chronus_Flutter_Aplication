import 'package:chronus/models/task_entity.dart';
import 'package:meta/meta.dart';

@immutable
class Task {
  final String taskName;
  final String taskDescription;
  final String userId;

  Task(this.taskName, this.taskDescription, this.userId);

  Task copyWith({String taskName, String taskDescription, String userId}) {
    return Task(taskName ?? this.taskName,
        taskDescription ?? this.taskDescription, userId ?? this.userId);
  }

  @override
  int get hashCode => taskName.hashCode ^ taskDescription.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          taskName == other.taskName &&
          taskDescription == other.taskDescription &&
          userId == other.userId;

  @override
  String toString() {
    return 'Task{completedTime: $taskName, taskDescription: $taskDescription, userId: $userId}';
  }

  TaskEntity toEntity() {
    return TaskEntity(taskName, taskDescription, userId);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(entity.taskName, entity.taskDescription, entity.userId);
  }
}
