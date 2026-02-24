import 'package:lara_chatbot/core/interfaces/domain/usecase.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';
import 'package:lara_chatbot/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetMessageListUsecase
    implements FutureUsecase<List<MessageEntity>?, void> {
  final DashboardRepository repository;

  GetMessageListUsecase(this.repository);

  @override
  Future<List<MessageEntity>?> execute([void input]) async =>
      await repository.getMessageList();
}
