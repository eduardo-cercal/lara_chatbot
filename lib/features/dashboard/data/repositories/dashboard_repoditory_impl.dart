import 'dart:convert';
import 'package:lara_chatbot/features/dashboard/data/datasources/dashboard_datasource.dart';
import 'package:lara_chatbot/features/dashboard/data/models/message_model.dart';
import 'package:lara_chatbot/features/dashboard/domain/entities/message_entity.dart';
import 'package:lara_chatbot/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepoditoryImpl implements DashboardRepository {
  final DashboardDatasource datasource;

  DashboardRepoditoryImpl(this.datasource);

  @override
  Future<List<MessageEntity>?> getMessageList() async {
    final resultEncoded = await datasource.getMessageList();
    if (resultEncoded.isEmpty) {
      return null;
    }
    final result = jsonDecode(resultEncoded);
    return result
        .map<MessageModel>((json) => MessageModel.fronJson(json))
        .toList();
  }

  @override
  Future<void> saveMessageList(List<MessageEntity> list) async {
    final modelList = list
        .map((entity) => MessageModel.fronEntitty(entity))
        .toList();

    await datasource.saveMessageList(
      jsonEncode(modelList.map((model) => model.toJson()).toList()),
    );
  }
}
