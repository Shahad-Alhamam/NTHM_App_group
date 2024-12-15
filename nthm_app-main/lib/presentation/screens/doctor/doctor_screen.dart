import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:nthm_app/logic/cubit/doctor/doctor_cubit.dart';
import 'package:nthm_app/presentation/screens/chat/chat_screen.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: BlocProvider(
        create: (_) => DoctorCubit()..fetchDoctors(),
        child: BlocBuilder<DoctorCubit, List<Map<String, dynamic>>>(
          builder: (context, doctors) {
            if (doctors.isEmpty) {
              return const Center(child: Text('No doctors found'));
            }

            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];

                return ListTile(
                  title: Text(doctor['name']),
                  subtitle: Text(doctor['email']),
                  onTap: () async {
                    // Fetch the current user ID from SharedPreferences
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? currentUserId = prefs.getString('userUID');

                    // Create or fetch the chat ID
                    // Assuming a function exists to get or create a chat ID:
                    String chatId = await getChatId(currentUserId, doctor['uid']);

                    // Navigate to the chat screen with the required parameters
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatId: chatId,
                          currentUserId: currentUserId!,
                          receiverId: doctor['uid'],
                        ),
                      ),
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

  // Example function to get or create a chat ID
  Future<String> getChatId(String? currentUserId, String receiverId) async {
    // Implement your logic here to create or retrieve a chat ID
    // For demonstration, returning a hardcoded string
    return 'chat_${currentUserId}_$receiverId'; // Use a unique identifier for the chat ID
  }
}
