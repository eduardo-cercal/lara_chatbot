import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/dashboard/presentation/dashboard_controller.dart';

class NewChatFloatingActionButton extends StatelessWidget {
  const NewChatFloatingActionButton({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final history = await Get.toNamed('/chat');
        controller.addToList(history);
      },
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.add_comment_rounded, color: Colors.white),
    );
  }
}
