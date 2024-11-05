import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createChatRoom(
    String chatCode,
    String userName,
    String groupName,
  ) async {
    await _firestore.collection('chatRooms').doc(chatCode).set({
      'chatCode': chatCode,
      'createdBy': userName,
      'members': [userName],
      'groupName': groupName,
    });
  }

  Future<DocumentSnapshot?> getChatRoom(String chatCode) async {
    return await _firestore.collection('chatRooms').doc(chatCode).get();
  }

  Future<void> addUserToChatRoom(
    String chatCode,
    String userName,
  ) async {
    await _firestore.collection('chatRooms').doc(chatCode).update(
      {
        'members': FieldValue.arrayUnion([userName]),
      },
    );
  }

  Stream<QuerySnapshot> getUserChatRooms(String userName) {
    return _firestore
        .collection('chatRooms')
        .where('members', arrayContains: userName)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessagesStream(String chatCode) {
    return _firestore
        .collection('chatRooms')
        .doc(chatCode)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String chatCode, String sender, String text) async {
    await _firestore
        .collection('chatRooms')
        .doc(chatCode)
        .collection('messages')
        .add({
      'text': text,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
