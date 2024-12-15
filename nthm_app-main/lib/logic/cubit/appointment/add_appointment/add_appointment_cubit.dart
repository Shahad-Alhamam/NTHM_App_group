import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAppointmentCubit extends Cubit<List<Map<String, dynamic>>> {
  AddAppointmentCubit() : super([]);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController medicationController = TextEditingController();
  final TextEditingController dosesController = TextEditingController();

  // Add appointment data
  Future<void> addAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUID = prefs.getString('userUID');

    final String medicationName = medicationController.text;
    final int doses = int.tryParse(dosesController.text) ?? 0;
    final List<String> times = state.map((timeData) => timeData["time"] as String).toList();

    if (userUID == null) {
      print("Error: User UID not found.");
      return;
    }

    if (startDate == null || endDate == null || medicationName.isEmpty || times.isEmpty) {
      print("Error: One or more fields are empty.");
      return;
    }

    try {
      // Reference to the user's document
      DocumentReference userDoc = firestore.collection('users').doc(userUID);

      // Add a new appointment under the user's "appointments" subcollection
      await userDoc.collection('appointments').add({
        'medicationName': medicationName,
        'doses': doses,
        'times': times, // Store selected times
        'startDate': startDate!,
        'endDate': endDate!,
      });

      print("Appointment added successfully!");
    } catch (e) {
      print("Error adding appointment: $e");
    }
  }

  // Add a new time to the list
  void addTime(String time) {
    if (time.isNotEmpty) {
      List<Map<String, dynamic>> updatedTimes = List.from(state);
      updatedTimes.add({"time": time});
      emit(updatedTimes);
    }
  }

  // Select start and end dates
  Future<void> selectStartDate(DateTime selectedDate) async {
    startDate = selectedDate;
  }

  Future<void> selectEndDate(DateTime selectedDate) async {
    endDate = selectedDate;
  }
}
