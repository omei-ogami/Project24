import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_24/models/activity.dart';

// --- Activitiy

class ActivityItemRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);

  Stream<List<Activity>> streamActivity() {
    return _db
      .collection('apps/activity-list')
      .orderBy('createdDate', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) 
          => Activity.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
      }
    );
  }

  Future<String> addItem(Activity item) async {
    Map<String, dynamic> itemMap = item.toMap();
    itemMap.remove('id');
    itemMap['createdDate'] = FieldValue.serverTimestamp();
    DocumentReference docRef = await _db
      .collection('apps/activity-list')
      .add(itemMap);
    return docRef.id;
  }
}