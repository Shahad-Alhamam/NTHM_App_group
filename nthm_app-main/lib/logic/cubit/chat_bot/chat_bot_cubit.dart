import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/data/models/chat_bot_model.dart';
import 'package:nthm_app/logic/cubit/chat_bot/chat_bot_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotCubit extends Cubit<ChatState> {
  final String _apiKey = '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';
  List<ChatMessage> _messages = [];

  ChatBotCubit() : super(ChatInitial());

  Future<void> sendMessage(String message) async {
    emit(ChatLoading());

    // Add user's message to the list
    _messages.add(ChatMessage(message: message, isUser: true));

    String medicalPrompt = 'You are a medical expert. Respond only with medical information. Question: $message';

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': 'You are a medical expert.'},
            {'role': 'user', 'content': medicalPrompt},
          ],
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botResponse = data['choices'][0]['message']['content'];

        // Add bot's response to the list
        _messages.add(ChatMessage(message: botResponse, isUser: false));
        emit(ChatSuccess(_messages, _messages.isNotEmpty));
      } else {
        emit(ChatFailure('Failed to load response.', response.statusCode));
      }
    } catch (e) {
      emit(ChatFailure('Error: $e', -1));
    }
  }

  void clearMessages() {
    _messages.clear();
    emit(ChatSuccess([], false)); // Update to indicate no messages
  }
}
