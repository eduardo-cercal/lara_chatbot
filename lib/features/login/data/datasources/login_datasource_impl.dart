import 'package:lara_chatbot/core/utils/failure.dart';
import 'package:lara_chatbot/features/login/data/datasources/login_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginDatasourceImpl implements LoginDatasource {
  final GoogleSignIn signIn;

  LoginDatasourceImpl(this.signIn);

  @override
  Future<void> googleSignIn() async {
    try {
      await signIn.initialize();
      await signIn.attemptLightweightAuthentication();
    } on GoogleSignInException catch (e) {
      throw GenericFailure(e.description);
    }
  }
}
