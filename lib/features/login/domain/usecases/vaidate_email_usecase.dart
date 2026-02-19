import 'package:lara_chatbot/core/interfaces/domain/usecase.dart';
import 'package:get/get_utils/get_utils.dart';

class VaidateEmailUsecase implements Usecase<void, String> {
  @override
  void execute([String? email]) {
    if (email == null || email.isEmpty) {
      throw EmptyEmailFailure();
    }

    if (!email.isEmail) {
      throw IsNotEmailFailure();
    }
  }
}
