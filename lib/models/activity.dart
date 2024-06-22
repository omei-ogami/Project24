import 'package:project_24/models/user.dart';

// There should be more properties

class Activity {
  Activity({
    required this.activityId,
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

  String? id;
  final String activityId;
  final String category;
  final String title;
  final String location;
  final String intro;
  final String time;
  final List<String> tags;
  final int capacity;
  final int people;
  final String organizer;
  final List<String> attendance;

  Activity._({
    required this.id,
    required this.activityId,
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

  factory Activity.fromMap(Map<String, dynamic> map, String? id) {
    return Activity._(
      id: id, 
      activityId: map['activityId'], 
      category: map['category'], 
      title: map['title'], 
      location: map['location'], 
      tags: List<String>.from(map['tags'] ?? []),
      intro: map['intro'], 
      time: map['time'], 
      capacity: map['capacity'], 
      people: map['people'], 
      organizer: map['organizer'], 
      attendance: List<String>.from(map['attendance'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'activityId': activityId, 
      'category': category, 
      'title': title, 
      'location': location, 
      'tags': tags, 
      'intro': intro, 
      'time': time, 
      'capacity': capacity, 
      'people': people, 
      'organizer': organizer, 
      'attendance': attendance,
    };
  }
}