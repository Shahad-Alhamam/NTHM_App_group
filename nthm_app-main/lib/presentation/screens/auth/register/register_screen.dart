import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/config/app_routes.dart';
import 'package:nthm_app/logic/cubit/register/register_cubit.dart';
import 'package:nthm_app/logic/cubit/register/register_state.dart';
import 'package:nthm_app/presentation/widgets/auth/sign_up_form.dart';
import 'package:nthm_app/presentation/widgets/background.dart';
import 'package:nthm_app/presentation/widgets/custom_text_form_field.dart';
import 'package:nthm_app/utils/responsive.dart';
import 'package:nthm_app/generated/assets.dart';
import 'package:nthm_app/utils/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: CustomDecorations.gradientBackground(),
        child: Padding(
          padding: EdgeInsets.all(responsive.getWidth(5)),
          child: BlocProvider(
            create: (context) => RegisterCubit(),
            child: BlocListener<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  Navigator.pushNamed(context, AppRoutes.layout);

                } else if (state is RegisterFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: SignUpForm(
                  nameController: nameController,
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
