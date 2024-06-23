import 'package:project_24/models/log_in_method.dart';

class User {
  String id; // use the ID from authentication service
  final String email;
  final String name;
  final String avatarUrl;
  late final List<LogInMethod> logInMethods;
  String? pushMessagingToken;

  // Read-only fields that can only be set by the system
  bool _isModerator = false;
  bool get isModerator => _isModerator;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
    logInMethods,
    this.pushMessagingToken,
  }) : logInMethods = logInMethods ?? [];

  User._({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
    logInMethods,
    this.pushMessagingToken,
    isModerator = false,
  })  : logInMethods = logInMethods ?? [],
        _isModerator = isModerator;

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User._(
      id: id,
      email: map['email'],
      name: map['name'],
      avatarUrl: map['avatarUrl'],
      logInMethods: (map['logInMethods'] as List<dynamic>)
          .map((logInMethod) => LogInMethod.values.byName(logInMethod))
          .toList(),
      pushMessagingToken: map['pushMessagingToken'],
      isModerator: map['isModerator'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatarUrl': avatarUrl,
      'logInMethods':
          logInMethods.map((logInMethod) => logInMethod.name).toList(),
      'pushMessagingToken': pushMessagingToken,
      'isModerator': _isModerator,
    };
  }
}
