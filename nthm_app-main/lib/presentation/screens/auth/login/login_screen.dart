import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/config/app_routes.dart';
import 'package:nthm_app/logic/cubit/login/login_cubit.dart';
import 'package:nthm_app/logic/cubit/login/login_sate.dart';
import 'package:nthm_app/presentation/widgets/auth/login_form.dart';
import 'package:nthm_app/presentation/widgets/background.dart';
import 'package:nthm_app/utils/responsive.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Scaffold(
      body: Container(
        decoration: CustomDecorations.gradientBackground(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.getWidth(5),
            vertical: responsive.getHeight(5),
          ),
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushNamed(context, AppRoutes.layout);
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: _formKey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

