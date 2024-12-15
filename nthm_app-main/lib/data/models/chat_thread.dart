import 'package:cloud_firestore/cloud_firestore.dart';

class ChatThread {
  final String chatId;
  final String participantId;
  final String lastMessage;
  final Timestamp lastTimestamp;

  ChatThread({
    required this.chatId,
    required this.participantId,
    required this.lastMessage,
    required this.lastTimestamp,
  });

  factory ChatThread.fromDocument(DocumentSnapshot doc) {
    return ChatThread(
      chatId: doc.id,
      participantId: doc['participantId'] as String,
      lastMessage: doc['lastMessage'] as String,
      lastTimestamp: doc['lastTimestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participantId': participantId,
      'lastMessage': lastMessage,
      'lastTimestamp': lastTimestamp,
    };
  }
}
