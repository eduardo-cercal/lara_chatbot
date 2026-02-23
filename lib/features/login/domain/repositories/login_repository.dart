import 'package:lara_chatbot/core/interfaces/domain/repository.dart';

abstract class LoginRepository implements Repository {
  Future<void> googleSignIn();
}
