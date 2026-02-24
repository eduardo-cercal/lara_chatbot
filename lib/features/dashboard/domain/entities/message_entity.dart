import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:lara_chatbot/core/interfaces/domain/entity.dart';

class MessageEntity extends Entity {
  final String title;
  final String lastMessage;
  final DateTime lastTimeSended;
  final List<ChatMessage> history;

  MessageEntity({
    required this.title,
    required this.lastMessage,
    required this.lastTimeSended,
    required this.history,
  });

  @override
  List<Object?> get props => [title, lastMessage, lastTimeSended, history];
}
