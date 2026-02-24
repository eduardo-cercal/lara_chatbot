import 'package:lara_chatbot/core/interfaces/domain/repository.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';

abstract class DashboardRepository implements Repository {
  Future<List<MessageEntity>?> getMessageList();

  Future<void> saveMessageList(List<MessageEntity> list);
}
