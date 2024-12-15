import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationRemindersCubit extends Cubit<List<Map<String, dynamic>>> {
  MedicationRemindersCubit() : super([]);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchReminders() async {
    try {
      // Retrieve the user's UID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userUID = prefs.getString('userUID');

      if (userUID == null) {
        print("Error: User UID not found.");
        return;
      }

      // Check for cached reminders in SharedPreferences
      String? cachedReminders = prefs.getString('cachedReminders');
      if (cachedReminders != null) {
        // Decode and cast cached reminders properly
        List<Map<String, dynamic>> cachedData = List<Map<String, dynamic>>.from(
            (jsonDecode(cachedReminders) as List).map((reminder) {
              return Map<String, dynamic>.from(reminder as Map);  // Cast each reminder to Map<String, dynamic>
            }));

        // Convert date strings back to DateTime
        cachedData = cachedData.map((reminder) {
          return {
            ...reminder,
            'startDate': DateTime.parse(reminder['startDate']),
            'endDate': DateTime.parse(reminder['endDate']),
          };
        }).toList();

        // Emit cached data
        emit(cachedData);
      }

      // Fetch the latest reminders from Firestore
      CollectionReference userAppointments = firestore
          .collection('users')
          .doc(userUID)
          .collection('appointments');

      QuerySnapshot snapshot = await userAppointments.get();

      List<Map<String, dynamic>> reminders = snapshot.docs.map((doc) {
        return {
          'medicationName': doc['medicationName'],
          'doses': doc['doses'],
          'times': List<String>.from(doc['times']),
          'startDate': (doc['startDate'] as Timestamp).toDate(),
          'endDate': (doc['endDate'] as Timestamp).toDate(),
        };
      }).toList();

      await prefs.setString('cachedReminders', jsonEncode(reminders));

      emit(reminders);
    } catch (e) {
      print("Error fetching reminders: $e");
    }
  }
}
