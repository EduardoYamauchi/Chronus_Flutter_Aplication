class TaskEntity {
  final String taskName;
  final String taskDescription;
  final String userId;

  TaskEntity(this.taskName, this.taskDescription, this.userId);

  @override
  int get hashCode =>
      taskName.hashCode ^ taskDescription.hashCode ^ userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          taskName == other.taskName &&
          taskDescription == other.taskDescription &&
          userId == other.userId;

  Map<String, Object> toJson() {
    return {
      "taskName": taskName,
      "taskDescription": taskDescription,
      "userId": userId,
    };
  }

  Map<String, Object> firstRegisterToJson() {
    return {
      "taskName": taskName,
      "taskDescription": taskDescription,
      "userId": userId,
      "hourglassesCompleted": 0,
    };
  }

  @override
  String toString() {
    return 'TaskEntity{projectName: $taskName, completedTime: $taskDescription, userId: $userId}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(json["taskName"] as String,
        json["taskDescription"] as String, json["userId"] as String);
  }
}
