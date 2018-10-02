import 'package:chronus/models/hourglass_entity.dart';
import 'package:meta/meta.dart';

@immutable
class Hourglass {
  final String completedTime;
  final String projectName;
  final String userId;

  Hourglass(this.completedTime, this.projectName, this.userId);

  Hourglass copyWith(
      {String completedTime, String projectName, String userId}) {
    return Hourglass(completedTime ?? this.completedTime,
        projectName ?? this.projectName, userId ?? this.userId);
  }

  @override
  int get hashCode => completedTime.hashCode ^ projectName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hourglass &&
          runtimeType == other.runtimeType &&
          completedTime == other.completedTime &&
          projectName == other.projectName &&
          userId == other.userId;

  @override
  String toString() {
    return 'Hourglass{completedTime: $completedTime, projectName: $projectName, userId: $userId}';
  }

  HourglassEntity toEntity() {
    return HourglassEntity(completedTime, projectName, userId);
  }

  static Hourglass fromEntity(HourglassEntity entity) {
    return Hourglass(entity.completedTime, entity.projectName, entity.userId);
  }
}
