import 'package:flutter/material.dart';
import 'package:nthm_app/generated/assets.dart';
import 'package:nthm_app/presentation/widgets/background.dart';
import 'package:nthm_app/utils/responsive.dart';
import 'package:nthm_app/config/app_routes.dart';  // Ensure you have this to reference routes

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Responsive responsive = Responsive(context);

    return Scaffold(
      body: Container(
        decoration: CustomDecorations.gradientBackground(),
        child: Padding(
          padding: EdgeInsets.all(responsive.getWidth(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                Assets.imagesLogo2,
                width: double.infinity,
              ),
              Text(
                "Let's get started!",
                style: theme.textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.getFontSize(18),
                ),
              ),
              SizedBox(height: responsive.getHeight(1.5)),
              Text(
                "Login to enjoy the features we've provided, and stay healthy!",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: Colors.blueGrey,
                  fontSize: responsive.getFontSize(16),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF368fd2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text('Login'),
                ),
              ),
              SizedBox(height: responsive.getHeight(1.5)),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF368fd2)),
                    foregroundColor: const Color(0xFF368fd2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              SizedBox(height: responsive.getHeight(3)),
            ],
          ),
        ),
      ),
    );
  }
}
