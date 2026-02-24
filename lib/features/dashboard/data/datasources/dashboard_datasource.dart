import 'package:lara_chatbot/core/interfaces/data/datasource.dart';

abstract class DashboardDatasource implements Datasource {
  Future<String> getMessageList();

  Future<void> saveMessageList(String value);
}
