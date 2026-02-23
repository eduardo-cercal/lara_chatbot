import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  RxBool get isLoading;
  RxnString get error;
  RxnString get routeName;
  RxBool get isObscured;
  RxnString get emailError;
  RxnString get passwordError;

  void validateEmail(String email);

  void validatePassword(String password);

  void setObscurePassword();

  Future<void> simulateLogin({required String email, required String password});

  Future<void> googleLogin();
}
