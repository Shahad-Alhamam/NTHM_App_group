import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/data/chat_service.dart';
import 'package:nthm_app/data/models/chat_thread.dart';
import 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final ChatService _chatService;
  StreamSubscription<List<ChatThread>>? _subscription;

  ChatListCubit(this._chatService) : super(ChatListState.initial());

  void fetchChatThreads(String userId) {
    emit(state.copyWith(isLoading: true));

    _subscription = _chatService.getChatThreads(userId).listen((chats) {
      emit(state.copyWith(chats: chats, isLoading: false));
    }, onError: (error) {
      emit(state.copyWith(isLoading: false));
      // Handle error (e.g., show a message)
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
