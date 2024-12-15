import 'package:nthm_app/data/models/chat_thread.dart';

class ChatListState {
  final List<ChatThread> chats;
  final bool isLoading;

  ChatListState({required this.chats, this.isLoading = false});

  factory ChatListState.initial() {
    return ChatListState(
      chats: [],
      isLoading: false,
    );
  }

  ChatListState copyWith({
    List<ChatThread>? chats,
    bool? isLoading,
  }) {
    return ChatListState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
