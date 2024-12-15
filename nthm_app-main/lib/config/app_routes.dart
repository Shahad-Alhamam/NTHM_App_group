import 'package:flutter/material.dart';
import 'package:nthm_app/presentation/screens/auth/login/login_screen.dart';
import 'package:nthm_app/presentation/screens/auth/register/register_screen.dart';
import 'package:nthm_app/presentation/screens/layout/layout_screen.dart';
import 'package:nthm_app/presentation/screens/welcome/welcome_screen.dart';

import '../presentation/screens/onborading/onboarding_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String layout = '/layout';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) =>  OnBoardingScreen(),
      welcome: (context) =>  const WelcomeScreen(),
      login: (context) => LoginScreen(),
      signup: (context) => SignUpScreen(),
      layout: (context) => Layout(),


    };
  }
}
