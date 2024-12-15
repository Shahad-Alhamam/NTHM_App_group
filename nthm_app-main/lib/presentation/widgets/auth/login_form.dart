import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/logic/cubit/login/login_cubit.dart';
import 'package:nthm_app/logic/cubit/login/login_sate.dart';
import 'package:nthm_app/presentation/widgets/custom_text_form_field.dart';
import 'package:nthm_app/utils/responsive.dart';
import 'package:nthm_app/utils/validators.dart';
import 'package:nthm_app/generated/assets.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesLogo2,
            width: double.infinity,
          ),
          SizedBox(height: responsive.getHeight(2)),
          Text(
            "Login to your account",
            style: TextStyle(
              fontSize: responsive.getFontSize(24),
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: responsive.getHeight(4)),
          CustomTextFormField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          SizedBox(height: responsive.getHeight(2)),
          CustomTextFormField(
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            isPassword: true,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: responsive.getHeight(5)),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const CircularProgressIndicator();
              }
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final email = emailController.text;
                      final password = passwordController.text;
                      BlocProvider.of<LoginCubit>(context)
                          .loginWithEmail(email, password);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF368fd2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Login'),
                ),
              );
            },
          ),
          SizedBox(height: responsive.getHeight(2)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text(
              "Don't have an account? Sign up",
              style: TextStyle(
                color: const Color(0xFF368fd2),
                fontSize: responsive.getFontSize(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
