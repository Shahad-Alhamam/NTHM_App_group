import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nthm_app/logic/cubit/register/register_cubit.dart';
import 'package:nthm_app/logic/cubit/register/register_state.dart';
import 'package:nthm_app/presentation/widgets/custom_text_form_field.dart';
import 'package:nthm_app/utils/responsive.dart';
import 'package:nthm_app/utils/validators.dart';
import 'package:nthm_app/generated/assets.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String userType = 'user';

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: responsive.getHeight(2)),
          SizedBox(
            height: responsive.getHeight(30),
            child: Image.asset(
              Assets.imagesLogo2,
              width: double.infinity,
            ),
          ),
          SizedBox(height: responsive.getHeight(2)),
          Text(
            "Create your account",
            style: TextStyle(
              fontSize: responsive.getFontSize(24),
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: responsive.getHeight(4)),
          CustomTextFormField(
            controller: widget.nameController,
            labelText: 'Name',
            hintText: 'Enter your name',
            validator: Validators.validateName,
          ),
          SizedBox(height: responsive.getHeight(2)),
          CustomTextFormField(
            controller: widget.emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          SizedBox(height: responsive.getHeight(2)),
          CustomTextFormField(
            controller: widget.passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            isPassword: true,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: responsive.getHeight(2)),

          // Add a title above the radio buttons
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Account Type:',
              style: TextStyle(
                fontSize: responsive.getFontSize(16),
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
          SizedBox(height: responsive.getHeight(1)),

          // Make the radio buttons on the same row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('User'),
                  value: 'user',
                  groupValue: userType,
                  onChanged: (value) {
                    setState(() {
                      userType = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Doctor'),
                  value: 'doctor',
                  groupValue: userType,
                  onChanged: (value) {
                    setState(() {
                      userType = value!;
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: responsive.getHeight(4)),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
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
                    if (widget.formKey.currentState!.validate()) {
                      final name = widget.nameController.text;
                      final email = widget.emailController.text;
                      final password = widget.passwordController.text;
                      BlocProvider.of<RegisterCubit>(context)
                          .registerWithEmail(name, email, password, userType);
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              );
            },
          ),
          SizedBox(height: responsive.getHeight(2)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              "Already have an account? Login",
              style: TextStyle(
                color: const Color(0xFF368fd2),
                fontSize: responsive.getFontSize(14),
              ),
            ),
          ),
          SizedBox(height: responsive.getHeight(10)),
        ],
      ),
    );
  }
}
