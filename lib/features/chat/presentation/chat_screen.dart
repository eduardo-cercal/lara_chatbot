import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.history});

  final List<ChatMessage>? history;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late LlmProvider _provider;
  final List<ChatMessage> history = [];
  late String _appBarTitle;

  @override
  void initState() {
    _provider = FirebaseProvider(
      history: widget.history,
      model: FirebaseAI.googleAI().generativeModel(
        model: 'gemini-3-flash-preview',
        systemInstruction: Content.system(
          'Seu nome é Lara. Você é um chatbot simples, amigável e direto. '
          'Você adora contar piadas curtas e fazer comentários engraçados. '
          'Suas respostas devem ser concisas e em português do Brasil.',
        ),
      ),
    );
    _appBarTitle = widget.history?.first.text ?? 'Nova conversa';
    _provider.addListener(() {
      history.addAll(_provider.history);
      _updateTitle();
    });
    super.initState();
  }

  void _updateTitle() {
    if (_provider.history.isNotEmpty) {
      final firstMsg = _provider.history.first.text;
      // Só atualiza se o título for diferente para disparar a animação
      if (_appBarTitle != firstMsg) {
        setState(() {
          _appBarTitle = firstMsg!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              _appBarTitle,
              key: ValueKey<String>(_appBarTitle),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading: BackButton(onPressed: () => Get.back(result: history)),
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
      ),
    );
  }
}
