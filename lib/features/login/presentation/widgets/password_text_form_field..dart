import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordFocusNode,
    required this.controller,
    required this.passwordController,
  });

  final FocusNode passwordFocusNode;
  final LoginController controller;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        focusNode: passwordFocusNode,
        textInputAction: .done,
        onEditingComplete: () {
          controller.validatePassword(passwordController.text);
          passwordFocusNode.unfocus();
        },
        onFieldSubmitted: (value) {
          controller.validatePassword(value);
          passwordFocusNode.unfocus();
        },
        obscureText: controller.isObscured.value,
        controller: passwordController,
        decoration: InputDecoration(
          labelText: 'Senha',
          border: const OutlineInputBorder(),

          floatingLabelStyle: TextStyle(color: Colors.blueAccent),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isObscured.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: controller.setObscurePassword,
          ),
        ),
      );
    });
  }
}
