import 'package:lara_chatbot/core/interfaces/domain/usecase.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';
import 'package:lara_chatbot/features/dashboard/domain/repositories/dashboard_repository.dart';

class SaveMessageListUsecase
    implements FutureUsecase<void, List<MessageEntity>> {
  final DashboardRepository repository;

  SaveMessageListUsecase(this.repository);

  @override
  Future<void> execute([List<MessageEntity>? list]) async =>
      await repository.saveMessageList(list!);
}
