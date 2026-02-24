import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';
import 'package:lara_chatbot/features/login/presentation/widgets/divider_with_text.dart';
import 'package:lara_chatbot/features/login/presentation/widgets/email_text_form_field.dart';
import 'package:lara_chatbot/features/login/presentation/widgets/google_sign_in_button.dart';
import 'package:lara_chatbot/features/login/presentation/widgets/login_button.dart';
import 'package:lara_chatbot/features/login/presentation/widgets/password_text_form_field..dart';
import 'package:lara_chatbot/features/login/presentation/widgets/welcome_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});

  final LoginController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    widget.controller.error.listen((error) {
      if (error != null) {
        Get.snackbar('Erro!', error);
      }
    });

    widget.controller.routeName.listen((routeName) {
      if (routeName != null) {
        Get.offNamed(routeName);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WelcomeText(),
                const SizedBox(height: 40),
                EmailTextFormField(
                  controller: widget.controller,
                  emailController: emailController,
                  passwordFocusNode: passwordFocusNode,
                ),
                const SizedBox(height: 16),
                PasswordTextFormField(
                  passwordFocusNode: passwordFocusNode,
                  controller: widget.controller,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 24),
                LoginButton(
                  controller: widget.controller,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 32),
                DividerWithText(),
                const SizedBox(height: 24),
                GoogleSignInButton(controller: widget.controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
