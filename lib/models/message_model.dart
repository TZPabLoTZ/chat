import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final String userId;
  final Timestamp timestamp;

  Message(
      {required this.content, required this.userId, required this.timestamp});

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      content: doc['content'],
      userId: doc['userId'],
      timestamp: doc['timestamp'],
    );
  }
}
