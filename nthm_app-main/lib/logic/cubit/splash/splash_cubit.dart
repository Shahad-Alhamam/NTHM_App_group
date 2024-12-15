import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/config/is_first_time.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final bool isFirstTime = await isFirstTimeOpeningApp();
      String? userUID = prefs.getString('userUID');

      await Future.delayed(const Duration(seconds: 3));

      if (isFirstTime) {
        emit(NavigateToOnboarding());
      } else if (userUID != null) {
        emit(NavigateToLayout());
      } else {
        emit(NavigateToWelcome());
      }
    } catch (e) {
      print('Error accessing SharedPreferences: $e');
    }
  }

}
