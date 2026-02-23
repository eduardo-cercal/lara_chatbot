import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late LlmProvider _provider;

  @override
  void initState() {
    _provider = FirebaseProvider(
      model: FirebaseAI.googleAI().generativeModel(
        model: 'gemini-3-flash-preview',
        systemInstruction: Content.system(
          'Seu nome é Lara. Você é um chatbot simples, amigável e direto. '
          'Você adora contar piadas curtas e fazer comentários engraçados. '
          'Suas respostas devem ser concisas e em português do Brasil.',
        ),
      ),
    );
    _provider.addListener(() => print(_provider.history));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova conversa'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: LlmChatView(
        style: const LlmChatViewStyle(
          backgroundColor: Colors.white,
          // Estilo da bolha da Lara (IA)
          llmMessageStyle: LlmMessageStyle(
            decoration: ShapeDecoration(
              color: Color(0xFFE3F2FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              ),
            ),
          ),
          // Estilo da bolha do Usuário
          userMessageStyle: UserMessageStyle(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              ),
              color: Colors.blueAccent,
            ), // Azul do seu Dashboard
            textStyle: TextStyle(color: Colors.white),
          ),
        ),

        // Mensagem de boas-vindas da Lara
        welcomeMessage:
            'Oi! Sou a Lara. Sabia que o computador foi ao médico? Ele estava com um vírus! 😂 Como posso te ajudar hoje?',
        enableAttachments: false,
        provider: _provider,
      ),
    );
  }
}
