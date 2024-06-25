import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_24/models/message.dart';

class FriendsMessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Message>> streamMessages(String id, String friendId) {
    return _db
        .collection('apps/dating-app/users')
        .doc(id)
        .collection('friends')
        .doc(friendId)
        .collection('messages')
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<String> addMessage(Message message, String id, String friendId) async {
    Map<String, dynamic> messageMap = message.toMap();
    // Remove 'id' because Firestore automatically generates a unique document ID for each new document added to the collection.
    messageMap.remove('id');
    // Ensure 'createdDate' is set by the server to maintain consistency across different clients, independent of local time settings.
    messageMap['createdDate'] = FieldValue.serverTimestamp();
    DocumentReference docRef = await _db
        .collection('apps/dating-app/users')
        .doc(id)
        .collection('friends')
        .doc(friendId)
        .collection('messages')
        .add(messageMap); // write to local cache immediately
    return docRef.id;
  }

  Future<void> deleteMessage(String messageId) async {
    await _db
        .collection('apps/dating-app/messages')
        .doc(messageId)
        .delete(); // write to local cache immediately
  }
}
