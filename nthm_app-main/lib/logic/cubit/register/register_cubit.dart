import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:nthm_app/logic/cubit/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  RegisterCubit() : super(RegisterInitial());

  Future<void> registerWithEmail(String name, String email, String password, String userType) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await Future.wait([
          user.updateDisplayName(name),
          user.updatePhotoURL(
              'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg'
          ),
        ]);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userUID', user.uid);
        await prefs.setString('userName', name);
        await prefs.setString('userEmail', email);
        await prefs.setString('userPhoto', user.photoURL ?? '');
        await prefs.setString('userPhone', '');

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'photo': user.photoURL,
          'phone': '',
          'userType': userType,
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure('User creation failed.'));
      }
    } on FirebaseAuthException catch (e) {
      final errorMessages = {
        'email-already-in-use': 'The email address is already in use.',
        'invalid-email': 'The email address is invalid.',
        'weak-password': 'The password is too weak.'
      };
      emit(RegisterFailure(errorMessages[e.code] ?? 'Unknown error occurred.'));
    } catch (e) {
      emit(RegisterFailure('Unexpected error occurred: $e'));
    }
  }
}
