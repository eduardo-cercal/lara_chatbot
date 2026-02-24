import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';

abstract class DashboardController extends GetxController {
  RxBool get isLoading;
  RxList<MessageEntity> get messageList;

  void addToList(List<ChatMessage> history);

  void updateList({
    required List<ChatMessage> history,
    required MessageEntity message,
  });

  Future<void> getMessageList();
}
