import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lara_chatbot/features/dashboard/presentation/dashboard_controller.dart';

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

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final history = await Get.toNamed('/chat');
          widget.controller.addToList(history);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add_comment_rounded, color: Colors.white),
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
                    widget.controller.updateList(
                      history: history,
                      message: message,
                    );
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    DateFormat(
                                      'HH:mm',
                                    ).format(message.lastTimeSended),
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
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
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
            },
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ilustração simples com ícone
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: .1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 80,
                    color: Colors.blue[400],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Nenhum chat por aqui',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Parece que você ainda não iniciou nenhuma conversa. Que tal começar agora?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
    );
  }
}
