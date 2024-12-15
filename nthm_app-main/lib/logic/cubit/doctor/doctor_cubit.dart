import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCubit extends Cubit<List<Map<String, dynamic>>> {
  DoctorCubit() : super([]);

  Future<void> fetchDoctors() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userType', isEqualTo: 'doctor')
          .get();

      final doctors = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      emit(doctors);
    } catch (e) {
      print('Error fetching doctors: $e');
      emit([]);
    }
  }
}
