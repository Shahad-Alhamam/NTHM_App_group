import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/data/chat_service.dart';
import 'package:nthm_app/logic/cubit/chat_list/chat_list_cubit.dart';
import 'package:nthm_app/logic/cubit/chat_list/chat_list_state.dart';
import 'package:nthm_app/presentation/screens/chat/chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final String currentUserId;

  const ChatListScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatListCubit(ChatService())..fetchChatThreads(currentUserId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          backgroundColor: const Color(0xFF368fd2),

        ),
        body: BlocBuilder<ChatListCubit, ChatListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.chats.isEmpty) {
              return const Center(child: Text('No chats available.'));
            }

            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(chat.participantId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: const Text('Loading...'),
                        subtitle: Text(chat.lastMessage),
                        trailing: Text(
                          _formatTimestamp(chat.lastTimestamp),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      );
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: const Text('Unknown User'),
                        subtitle: Text(chat.lastMessage),
                        trailing: Text(
                          _formatTimestamp(chat.lastTimestamp),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      );
                    }

                    final userData = snapshot.data!;
                    final dataMap = userData.data() as Map<String, dynamic>;
                    final userName = dataMap['name'] ?? 'Unknown';


                    final userAvatar = dataMap.containsKey('avatarUrl') ? dataMap['avatarUrl'] as String? : null;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: (userAvatar != null && userAvatar.isNotEmpty)
                            ? NetworkImage(userAvatar)
                            : null,
                        child: (userAvatar == null || userAvatar.isEmpty)
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(userName),
                      subtitle: Text(chat.lastMessage),
                      trailing: Text(
                        _formatTimestamp(chat.lastTimestamp),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              chatId: chat.chatId,
                              currentUserId: currentUserId,
                              receiverId: chat.participantId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Helper method to format timestamps
  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      // Today: show time
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      // Within the last week: show weekday
      return _weekdayString(date.weekday);
    } else {
      // Older: show date
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  // Helper method to convert weekday number to string
  String _weekdayString(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}

