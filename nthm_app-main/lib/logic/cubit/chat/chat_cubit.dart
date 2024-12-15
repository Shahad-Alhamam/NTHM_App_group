import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/data/chat_service.dart';
import 'package:nthm_app/data/models/message_model.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;

  ChatCubit(this.chatService) : super(ChatState.initial());

  void fetchMessages(String currentUserId, String chatId, {DocumentSnapshot? lastDocument}) {
    emit(state.copyWith(isLoading: true));

    chatService.getChatMessages(currentUserId, chatId, lastDocument: lastDocument).listen((messages) {
      emit(state.copyWith(
        messages: messages,
        isLoading: false,
      ));
    }, onError: (error) {
      emit(state.copyWith(isLoading: false));

    });
  }

  Future<void> sendMessage(String currentUserId, String receiverId, String chatId, String text) async {
    final message = ChatMessage(
      senderId: currentUserId,
      receiverId: receiverId,
      text: text,
      timestamp: Timestamp.now(),
    );

    await chatService.sendMessage(
      senderId: currentUserId,
      receiverId: receiverId,
      chatId: chatId,
      message: message,
    );
  }
}
