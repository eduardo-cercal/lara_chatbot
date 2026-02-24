import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.controller,
    required this.emailController,
    required this.passwordController,
  });

  final LoginController controller;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async => await controller.simulateLogin(
          email: emailController.text,
          password: passwordController.text,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return const Text('Entrar', style: TextStyle(color: Colors.white));
        }),
      ),
    );
  }
}
