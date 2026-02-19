import 'package:lara_chatbot/core/interfaces/domain/usecase.dart';
import 'package:lara_chatbot/core/utils/failure.dart';
import 'package:lara_chatbot/features/login/domain/entities/email_and_password_entity.dart';
import 'package:lara_chatbot/features/login/utils/login_mapper.dart';

class EmailAndPasswordLoginUsecase
    implements FutureUsecase<void, EmailAndPasswordEntity> {
  @override
  Future<void> execute([EmailAndPasswordEntity? entity]) async {
    try {
      _isCorrectEmail(entity!.email);
      _isCorrectPassword(entity.password);
    } on Failure {
      rethrow;
    }
  }

  void _isCorrectEmail(String email) {
    if (email != LoginMapper.loginEmail) {
      throw WrongEmailFailure();
    }
  }

  void _isCorrectPassword(String password) {
    if (password != LoginMapper.loginPassword) {
      throw WrongPasswordFailure();
    }
  }
}
