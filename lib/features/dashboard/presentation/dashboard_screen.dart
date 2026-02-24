import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/dashboard/presentation/dashboard_controller.dart';
import 'package:lara_chatbot/features/dashboard/presentation/widgets/empty_list_widget.dart';
import 'package:lara_chatbot/features/dashboard/presentation/widgets/message_history_list_tile.dart';
import 'package:lara_chatbot/features/dashboard/presentation/widgets/new_chat_floating_action_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.controller});

  final DashboardController controller;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.getMessageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[50], // Fundo levemente acinzentado para contraste
      appBar: AppBar(
        title: const Text(
          'Mensagens',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      floatingActionButton: NewChatFloatingActionButton(
        controller: widget.controller,
      ),

      body: Obx(() {
        if (widget.controller.isLoading.value) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (widget.controller.messageList.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ), // Respiro nas laterais
            itemCount: widget.controller.messageList.length,
            itemBuilder: (context, index) {
              final message = widget.controller.messageList[index];
              return MessageHistoryListTile(
                message: message,
                controller: widget.controller,
              );
            },
          );
        }
        return EmptyListWidget();
      }),
    );
  }
}
