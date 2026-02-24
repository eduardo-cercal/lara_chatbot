import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.controller,
    required this.emailController,
    required this.passwordFocusNode,
  });

  final LoginController controller;
  final TextEditingController emailController;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        textInputAction: .next,
        keyboardType: .emailAddress,
        onEditingComplete: () => controller.validateEmail(emailController.text),
        onFieldSubmitted: (value) {
          controller.validateEmail(value);
          FocusScope.of(context).requestFocus(passwordFocusNode);
        },
        controller: emailController,
        autofocus: true,
        decoration: InputDecoration(
          errorText: controller.emailError.value,
          labelText: 'E-mail',
          floatingLabelStyle: TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      );
    });
  }
}
