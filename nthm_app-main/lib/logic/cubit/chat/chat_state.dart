import 'package:nthm_app/data/models/message_model.dart';

class ChatState {
  final bool isLoading;
  final List<ChatMessage> messages;

  ChatState({required this.isLoading, required this.messages});

  factory ChatState.initial() {
    return ChatState(
      isLoading: false,
      messages: [],
    );
  }

  ChatState copyWith({
    bool? isLoading,
    List<ChatMessage>? messages,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
    );
  }
}
