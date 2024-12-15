// main.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/logic/cubit/chat_bot/chat_bot_cubit.dart';
import 'package:nthm_app/logic/cubit/splash/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/app_routes.dart';
import 'data/chat_service.dart';
import 'logic/cubit/appointment/add_appointment/add_appointment_cubit.dart';
import 'logic/cubit/appointment/medication_reminders_cubit.dart';
import 'logic/cubit/chat/chat_cubit.dart';
import 'logic/cubit/chat_list/chat_list_cubit.dart';
import 'logic/cubit/doctor/doctor_cubit.dart';
import 'logic/cubit/navigation/navigation_cubit.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  // Modify the constructor to accept SharedPreferences
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SharedPreferences>.value(value: prefs),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) => SplashCubit(),
          ),
          BlocProvider(
            create: (context) => AddAppointmentCubit(),
          ),
          BlocProvider(
            create: (context) => ChatBotCubit(),
          ),
          BlocProvider(
            create: (context) => MedicationRemindersCubit(),
          ),
          BlocProvider(
            create: (context) => DoctorCubit(),
          ),
          BlocProvider(
            create: (context) => ChatCubit(ChatService()),
          ),
          BlocProvider(
            create: (context) => ChatListCubit(ChatService()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
