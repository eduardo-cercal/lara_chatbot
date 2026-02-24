import 'package:flutter_ai_toolkit/src/providers/interface/chat_message.dart';
import 'package:get/get.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';
import 'package:lara_chatbot/features/dashboard/domain/usecases/get_message_list_usecase.dart';
import 'package:lara_chatbot/features/dashboard/domain/usecases/save_message_list_usecase.dart';
import 'package:lara_chatbot/features/dashboard/presentation/dashboard_controller.dart';

class GetxDashboardController extends GetxController
    implements DashboardController {
  final GetMessageListUsecase _getMessageListUsecase;
  final SaveMessageListUsecase _saveMessageListUsecase;

  GetxDashboardController({
    required GetMessageListUsecase getMessageListUsecase,
    required SaveMessageListUsecase saveMessageListUsecase,
  }) : _getMessageListUsecase = getMessageListUsecase,
       _saveMessageListUsecase = saveMessageListUsecase;

  final _isLoading = false.obs;
  final _messageList = <MessageEntity>[].obs;

  @override
  RxBool get isLoading => _isLoading;

  @override
  RxList<MessageEntity> get messageList => _messageList;

  @override
  void addToList(List<ChatMessage> history) {
    if (history.isEmpty) {
      return;
    }
    final entity = MessageEntity(
      title: history.first.text!,
      lastMessage: history.last.text!,
      lastTimeSended: DateTime.now(),
      history: history,
    );

    _messageList.insert(0, entity);
    _saveMessageList();
  }

  @override
  void updateList({
    required List<ChatMessage> history,
    required MessageEntity message,
  }) {
    if (history.isEmpty) {
      return;
    }

    _messageList.remove(message);
    addToList(history);
  }

  @override
  Future<void> getMessageList() async {
    _isLoading.value = true;
    final result = await _getMessageListUsecase.execute();
    if (result != null) {
      _messageList.addAll(result);
    }

    _isLoading.value = false;
  }

  Future<void> _saveMessageList() async =>
      await _saveMessageListUsecase.execute(_messageList);
}
