class HourglassEntity {

  final String completedTime;
  final String projectName;
  final String userId;

  HourglassEntity(this.completedTime, this.projectName, this.userId);

  @override
  int get hashCode =>
       projectName.hashCode ^ completedTime.hashCode ^ userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourglassEntity &&
          runtimeType == other.runtimeType &&
          projectName == other.projectName &&
          completedTime == other.completedTime &&
          userId == other.userId;

  Map<String, Object> toJson() {
    return {
      "projectName": projectName,
      "completedTime": completedTime,
      "userId": userId
    };
  }

  @override
  String toString() {
    return 'HourglassEntity{projectName: $projectName, completedTime: $completedTime, userId: $userId}';
  }

  static HourglassEntity fromJson(Map<String, Object> json) {
    return HourglassEntity(
      json["completedTime"] as String,
      json["projectName"] as String,
      json["userId"] as String
    );
  }
}
