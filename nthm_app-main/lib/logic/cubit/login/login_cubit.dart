import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nthm_app/logic/cubit/login/login_sate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginWithEmail(String email, String password) async {
    try {
      emit(LoginLoading());
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = userCredential.user?.uid;

      if (uid != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userUID', uid);

        emit(LoginSuccess());
      } else {
        emit(LoginFailure('UID is null.'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
