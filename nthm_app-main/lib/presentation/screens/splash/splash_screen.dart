import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/config/app_routes.dart';
import 'package:nthm_app/generated/assets.dart';
import 'package:nthm_app/logic/cubit/splash/splash_cubit.dart';
import 'package:nthm_app/logic/cubit/splash/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().checkAuthStatus();

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is NavigateToOnboarding) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
        } else if (state is NavigateToLayout) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.layout);
        } else if (state is NavigateToWelcome) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.imagesLogo),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF007BFF),
      ),
    );
  }
}

