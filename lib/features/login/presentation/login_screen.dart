import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';

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
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bem-vindo',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  // Campo E-mail
                  TextFormField(
                    textInputAction: .next,
                    keyboardType: .emailAddress,
                    onEditingComplete: () =>
                        widget.controller.validateEmail(emailController.text),
                    onFieldSubmitted: (value) {
                      widget.controller.validateEmail(value);
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    controller: emailController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: widget.controller.emailError.value,
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    focusNode: passwordFocusNode,
                    textInputAction: .done,
                    onEditingComplete: () {
                      widget.controller.validatePassword(
                        passwordController.text,
                      );
                      passwordFocusNode.unfocus();
                    },
                    onFieldSubmitted: (value) {
                      widget.controller.validatePassword(value);
                      passwordFocusNode.unfocus();
                    },
                    obscureText: widget.controller.isObscured.value,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          widget.controller.isObscured.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: widget.controller.setObscurePassword,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botão Login E-mail
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async =>
                          await widget.controller.simulateLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Obx(() {
                        if (widget.controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Ou entre com"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Botão Circular do Google
                  GestureDetector(
                    onTap: widget.controller.googleLogin,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
