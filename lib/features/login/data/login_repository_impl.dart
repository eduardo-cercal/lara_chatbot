import 'package:lara_chatbot/features/login/data/login_datasource.dart';
import 'package:lara_chatbot/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<void> googleSignIn() async => await datasource.googleSignIn();
}
