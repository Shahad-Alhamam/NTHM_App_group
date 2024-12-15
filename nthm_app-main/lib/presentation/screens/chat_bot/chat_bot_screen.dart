import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/logic/cubit/chat_bot/chat_bot_cubit.dart';
import 'package:nthm_app/logic/cubit/chat_bot/chat_bot_state.dart';

class ChatBotScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();


  ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF368fd2),
        title: const Text('Medical Chat Bot'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ChatBotCubit>().clearMessages();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBotCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatSuccess) {
                  // Display the conversation history
                  if (state.hasMessages) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final chatMessage = state.messages[index];
                        final isUserMessage = chatMessage.isUser;
                        final messageText = chatMessage.message;

                        return ListTile(
                          title: Align(
                            alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isUserMessage ? Colors.blue[200] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(messageText),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else if (state is ChatFailure) {
                  return Center(child: Text(state.error));
                }
                return _buildSuggestedQuestions();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask something...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _controller.text;
                    if (message.isNotEmpty) {
                      context.read<ChatBotCubit>().sendMessage(message);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build suggested questions
  Widget _buildSuggestedQuestions() {
    final List<String> _suggestedQuestions = [
      "What are the symptoms of flu?",
      "How can I manage stress effectively?",
      "What are the benefits of a balanced diet?",
      "When should I see a doctor?",
      "What is the difference between a cold and allergies?",
      // Add more suggested questions as needed
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Here are some medical questions you can ask:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestedQuestions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    title: Text(
                      _suggestedQuestions[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xFF368fd2), // Customize the color to match your theme
                    ),
                    onTap: () {
                      context.read<ChatBotCubit>().sendMessage(_suggestedQuestions[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
