import 'package:equatable/equatable.dart';
import 'package:nthm_app/data/models/chat_bot_model.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<ChatMessage> messages;
  final bool hasMessages; // New property

  ChatSuccess(this.messages, this.hasMessages);

  @override
  List<Object?> get props => [messages, hasMessages];
}

class ChatFailure extends ChatState {
  final String error;
  final int errorCode;

  ChatFailure(this.error, this.errorCode);

  @override
  List<Object?> get props => [error, errorCode];
}
