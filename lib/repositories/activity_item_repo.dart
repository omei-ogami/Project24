import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_24/models/activity.dart';

// --- Activitiy

class ActivityItemRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);

  Stream<List<Activity>> streamActivity() {
    return _db
        .collection('apps/dating-app/activity-list')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc)
            => Activity.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<String> addItem(Activity item) async {
    Map<String, dynamic> itemMap = item.toMap();
    itemMap.remove('id');
    itemMap['createdDate'] = FieldValue.serverTimestamp();
    DocumentReference docRef = await _db
      .collection('apps/dating-app/activity-list')
      .add(itemMap);
    return docRef.id;
  }

  Future<void> addAttendance(String id, String userId) async {
    await _db
        .collection('apps/dating-app/activity-list')
        .doc(id).update({
        'attendance': FieldValue.arrayUnion([userId]),
        'people': FieldValue.increment(1),
      });
  }

  Future<void> removeAttendance(String id, String userId) async {
    await _db
        .collection('apps/dating-app/activity-list')
        .doc(id).update({
        'attendance': FieldValue.arrayRemove([userId]),
        'people': FieldValue.increment(-1),
      });
  }
}