import 'package:lara_chatbot/core/interfaces/data/datasource.dart';

abstract class LoginDatasource implements Datasource {
  Future<void> googleSignIn();
}
