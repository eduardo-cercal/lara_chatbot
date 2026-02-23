import 'package:lara_chatbot/core/interfaces/domain/usecase.dart';
import 'package:lara_chatbot/core/utils/failure.dart';

class VaidatePasswordUsecase implements Usecase<void, String> {
  @override
  void execute([String? password]) {
    if (password!.length < 6) {
      throw InvaildLengthFaiure();
    }
  }
}
