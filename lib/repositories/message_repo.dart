import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_24/models/message.dart';

class MessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Message>> streamMessages() {
    return _db
        .collection('apps/group-chat/messages')
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<String> addMessage(Message message) async {
    Map<String, dynamic> messageMap = message.toMap();
    // Remove 'id' because Firestore automatically generates a unique document ID for each new document added to the collection.
    messageMap.remove('id');
    // Ensure 'createdDate' is set by the server to maintain consistency across different clients, independent of local time settings.
    messageMap['createdDate'] = FieldValue.serverTimestamp();
    DocumentReference docRef = await _db
        .collection('apps/dating-app/messages')
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
