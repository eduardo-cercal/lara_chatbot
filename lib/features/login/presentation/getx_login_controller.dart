import 'package:get/get.dart';
import 'package:lara_chatbot/core/utils/failure.dart';
import 'package:lara_chatbot/features/login/domain/entities/email_and_password_entity.dart';
import 'package:lara_chatbot/features/login/domain/usecases/email_and_password_login_usecase.dart';
import 'package:lara_chatbot/features/login/domain/usecases/google_sign_in_usecase.dart';
import 'package:lara_chatbot/features/login/domain/usecases/validate_email_usecase.dart';
import 'package:lara_chatbot/features/login/domain/usecases/validate_password_usecase.dart';
import 'package:lara_chatbot/features/login/presentation/login_controller.dart';

class GetxLoginController extends GetxController implements LoginController {
  final ValidateEmailUsecase _validateEmailUsecase;
  final ValidatePasswordUsecase _validatePasswordUsecase;
  final EmailAndPasswordLoginUsecase _emailAndPasswordLoginUsecase;
  final GoogleSignInUsecase _googleSignInUsecase;

  GetxLoginController({
    required ValidateEmailUsecase validateEmailUsecase,
    required ValidatePasswordUsecase validatePasswordUsecase,
    required EmailAndPasswordLoginUsecase emailAndPasswordLoginUsecase,
    required GoogleSignInUsecase googleSignInUsecase,
  }) : _validateEmailUsecase = validateEmailUsecase,
       _validatePasswordUsecase = validatePasswordUsecase,
       _emailAndPasswordLoginUsecase = emailAndPasswordLoginUsecase,
       _googleSignInUsecase = googleSignInUsecase;

  final _error = RxnString();
  final _isLoading = false.obs;
  final _isObcured = true.obs;
  final _routeName = RxnString();
  final _emailError = RxnString();
  final _passwordError = RxnString();

  @override
  RxnString get error => _error;

  @override
  RxBool get isLoading => _isLoading;

  @override
  RxBool get isObscured => _isObcured;

  @override
  RxnString get routeName => _routeName;

  @override
  void setObscurePassword() => _isObcured.value = !_isObcured.value;

  @override
  RxnString get emailError => _emailError;

  @override
  RxnString get passwordError => _passwordError;

  @override
  Future<void> googleLogin() async {
    try {
      _error.value = null;
      _isLoading.value = true;
      await _googleSignInUsecase.execute();
      _routeName.value = '/dashboard';
    } on Failure catch (e) {
      _error.value = e.message;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> simulateLogin({
    required String email,
    required String password,
  }) async {
    try {
      _error.value = null;
      _isLoading.value = true;
      await Future.delayed(Duration(seconds: 3));

      _emailAndPasswordLoginUsecase.execute(
        EmailAndPasswordEntity(email: email, password: password),
      );
      _routeName.value = '/dashboard';
    } on Failure catch (e) {
      _error.value = e.message;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void validateEmail(String email) {
    try {
      _emailError.value = null;
      _validateEmailUsecase.execute(email);
    } on Failure catch (e) {
      _emailError.value = e.message;
    }
  }

  @override
  void validatePassword(String password) {
    try {
      _passwordError.value = null;
      _validatePasswordUsecase.execute(password);
    } on Failure catch (e) {
      _passwordError.value = e.message;
    }
  }
}
