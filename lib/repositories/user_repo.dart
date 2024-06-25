import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_24/models/user.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> streamUser(String userId) {
    return _db
        .collection('apps/dating-app/users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.data() == null
          ? null
          : User.fromMap(snapshot.data()!, snapshot.id);
    });
  }

  Future<void> createOrUpdateUser(User user) async {
    Map<String, dynamic> userMap = user.toMap();
    await _db
        .collection('apps/dating-app/users')
        .doc(user.id)
        .set(userMap); // write to local cache immediately
  }

  Future<User?> getUserByEmail(String email) async {
    QuerySnapshot querySnapshot = await _db
        .collection('apps/dating-app/users')
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    return User.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>,
        querySnapshot.docs.first.id);
  }

  Future<void> updatePushMessagingToken(String userId, String? token) async {
    await _db
        .collection('apps/dating-app/users')
        .doc(userId)
        .update({'pushMessagingToken': token});
  }

  Future<void> addActivityToUserList(String userId, String activityId) async {
    await _db
        .collection('apps/dating-app/users')
        .doc(userId).update({
        'joinedActivities': FieldValue.arrayUnion([activityId]),
      });
  }
}
