import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';
import 'package:lara_chatbot/features/dashboard/presentation/dashboard_controller.dart';

class MessageHistoryListTile extends StatelessWidget {
  const MessageHistoryListTile({
    super.key,
    required this.message,
    required this.controller,
  });

  final MessageEntity message;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        // Para efeito de clique respeitando o arredondamento
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          final history = await Get.toNamed(
            '/chat',
            arguments: {'history': message.history},
          );
          controller.updateList(history: history, message: message);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Avatar da Lara ou Ícone da conversa
              CircleAvatar(
                backgroundColor: Colors.blue[50],
                radius: 25,
                child: Icon(
                  Icons.face_retouching_natural_rounded,
                  color: Colors.blue[400],
                ),
              ),
              const SizedBox(width: 16),

              // Textos (Título e última mensagem)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(message.lastTimeSended),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
