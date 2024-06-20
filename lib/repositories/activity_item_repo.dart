import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_24/models/activity.dart';

class ActivityItemRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);
}