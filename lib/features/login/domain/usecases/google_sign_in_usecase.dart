import 'package:lara_chatbot/core/interfaces/domain/usecase.dart';
import 'package:lara_chatbot/features/login/domain/repositories/login_repository.dart';

class GoogleSignInUsecase implements FutureUsecase<void, void> {
  final LoginRepository repository;

  GoogleSignInUsecase(this.repository);

  @override
  Future<void> execute([void input]) async => await repository.googleSignIn();
}
