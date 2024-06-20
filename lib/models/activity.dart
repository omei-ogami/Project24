import 'package:project_24/models/user.dart';

// There should be more properties

class Activity {
  const Activity({
    required this.id,
    required this.category,
    required this.title,
    required this.location,
    required this.tags,
    required this.intro,
    required this.time,
    required this.capacity,
    required this.people,
    required this.organizer,
    required this.attendance,
  });

  final String id;
  final String category;
  final String title;
  final String location;
  final String intro;
  final String time;
  final List<String> tags;
  final int capacity;
  final int people;
  final User organizer;
  final List<User> attendance;
}