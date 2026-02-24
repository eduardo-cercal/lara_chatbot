import 'package:hive_ce/hive_ce.dart';
import 'package:lara_chatbot/features/dashboard/data/datasources/dashboard_datasource.dart';

class DashboardDatasourceImpl implements DashboardDatasource {
  final Box box;

  DashboardDatasourceImpl(this.box);

  @override
  Future<String> getMessageList() async =>
      await box.get('messageList', defaultValue: '');

  @override
  Future<void> saveMessageList(String value) async =>
      await box.put('messageList', value);
}
