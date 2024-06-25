import 'package:project_24/models/user.dart';

class Friend {
  Friend({
    this.activityId,
    required this.userName,
    required this.avatarUrl,
  });

  String? activityId;
  final String userName;
  final String avatarUrl;

  Friend._({
    this.activityId,
    required this.userName,
    required this.avatarUrl,
  });

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend._(
      activityId: map['activityId'],
      userName: map['userName'],
      avatarUrl: map['avatarUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activityId': activityId,
      'userName': userName,
      'avatarUrl': avatarUrl,
    };
  }
}