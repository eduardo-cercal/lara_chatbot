import 'package:get/get.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';

class GetxLoginController extends GetxController implements LoginController {
  @override
  // TODO: implement error
  RxnString get error => throw UnimplementedError();

  @override
  // TODO: implement isLoading
  RxBool get isLoading => throw UnimplementedError();

  @override
  // TODO: implement isObscured
  RxBool get isObscured => throw UnimplementedError();

  @override
  // TODO: implement routeName
  RxnString get routeName => throw UnimplementedError();

  @override
  void setObscurePassword() {
    // TODO: implement setObscurePassword
  }

  @override
  Future<void> googleLogin() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  @override
  Future<void> simulateLogin({
    required String email,
    required String password,
  }) {
    // TODO: implement simulateLogin
    throw UnimplementedError();
  }

  @override
  void validateEmail(String email) {
    // TODO: implement validateEmail
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }
}
