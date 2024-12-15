import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nthm_app/data/models/message_model.dart';
import 'models/chat_thread.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String chatId,
    required ChatMessage message,
  }) async {
    final senderChatRef = _firestore.collection('users').doc(senderId).collection('chats').doc(chatId);
    final receiverChatRef = _firestore.collection('users').doc(receiverId).collection('chats').doc(chatId);

    final batch = _firestore.batch();

    // Prepare message data
    final messageData = message.toMap();
    final senderMessageRef = senderChatRef.collection('messages').doc();
    final receiverMessageRef = receiverChatRef.collection('messages').doc();

    // Add messages to sender and receiver
    batch.set(senderMessageRef, messageData);
    batch.set(receiverMessageRef, messageData);

    // Prepare chat update data
    final chatUpdateDataForSender = {
      'lastMessage': message.text,
      'lastTimestamp': message.timestamp,
      'participantId': receiverId,
    };

    final chatUpdateDataForReceiver = {
      'lastMessage': message.text,
      'lastTimestamp': message.timestamp,
      'participantId': senderId,
    };

    // Update chat threads in the batch
    batch.set(senderChatRef, chatUpdateDataForSender, SetOptions(merge: true));
    batch.set(receiverChatRef, chatUpdateDataForReceiver, SetOptions(merge: true));

    await batch.commit();
  }

  Stream<List<ChatMessage>> getChatMessages(String currentUserId, String chatId, {DocumentSnapshot? lastDocument}) {
    Query query = _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(20);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromDocument(doc))
        .toList());
  }

  Stream<List<ChatThread>> getChatThreads(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .orderBy('lastTimestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ChatThread.fromDocument(doc)).toList());
  }
}
