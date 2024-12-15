import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/presentation/screens/appointment/add_appointment/add_appointment_screen.dart';
import 'package:nthm_app/presentation/screens/appointment/medication_reminders_screen.dart';
import 'package:nthm_app/presentation/screens/chat_bot/chat_bot_screen.dart';
import 'package:nthm_app/presentation/screens/chat_list/chat_list_screen.dart';
import 'package:nthm_app/presentation/screens/doctor/doctor_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nthm_app/logic/cubit/navigation/navigation_cubit.dart';
import 'package:nthm_app/presentation/screens.dart';
import 'package:nthm_app/presentation/screens/profile/profile_screen.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  Future<String?> _getUserUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUID');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user found'));
        }

        final String userUID = snapshot.data!;

        final List<Widget> _screens = [
          const DoctorScreen(),
          ChatListScreen(currentUserId: userUID,),

          const MedicationRemindersScreen(),
          ProfileScreen(userId: userUID),
        ];

        return BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return Scaffold(
              body: _screens[currentIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatBotScreen(),
                    ),
                  );
                },
                backgroundColor: const Color(0xFF368fd2),
                child: const Icon(Icons.help_outline),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: (index) {
                  context.read<NavigationCubit>().navigateTo(index);
                },
                selectedItemColor: const Color(0xFF368fd2),
                unselectedItemColor: Colors.grey.shade600,
                showUnselectedLabels: true,
                selectedFontSize: 14,
                unselectedFontSize: 12,
                elevation: 10,
                iconSize: 28,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    activeIcon: Icon(Icons.chat_outlined),
                    label: 'chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_outlined),
                    activeIcon: Icon(Icons.calendar_today),
                    label: 'Appointments',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
