import 'package:lara_chatbot/features/login/domain/entities/email_and_password_entity.dart';

abstract class LoginRepository {
  Future<void> emailAndPasswordLogin(EmailAndPasswordEntity entity);
}
