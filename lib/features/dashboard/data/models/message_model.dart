import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:lara_chatbot/core/interfaces/data/model.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity implements Model {
  MessageModel({
    required super.title,
    required super.lastMessage,
    required super.lastTimeSended,
    required super.history,
  });

  factory MessageModel.fronJson(Map<String, dynamic> json) => MessageModel(
    title: json['title'],
    lastMessage: json['lastMessage'],
    lastTimeSended: DateTime.fromMillisecondsSinceEpoch(json['lastTimeSended']),
    history: json['history']
        .map<ChatMessage>(((element) => ChatMessage.fromJson(element)))
        .toList(),
  );

  factory MessageModel.fronEntitty(MessageEntity entity) => MessageModel(
    title: entity.title,
    lastMessage: entity.lastMessage,
    lastTimeSended: entity.lastTimeSended,
    history: entity.history,
  );

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'lastMessage': lastMessage,
    'lastTimeSended': lastTimeSended.millisecondsSinceEpoch,
    'history': history.map((message) => message.toJson()).toList(),
  };
}
