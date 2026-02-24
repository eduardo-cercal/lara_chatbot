import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_ce/hive.dart';
import 'package:lara_chatbot/features/chat/presentation/chat_screen.dart';
import 'package:lara_chatbot/features/dashboard/data/datasources/dashboard_datasource_impl.dart';
import 'package:lara_chatbot/features/dashboard/data/repositories/dashboard_repoditory_impl.dart';
import 'package:lara_chatbot/features/dashboard/domain/usecases/get_message_list_usecase.dart';
import 'package:lara_chatbot/features/dashboard/domain/usecases/save_message_list_usecase.dart';
import 'package:lara_chatbot/features/dashboard/presentation/dashboard_screen.dart';
import 'package:lara_chatbot/features/dashboard/presentation/getx_dashboard_controller.dart';
import 'package:lara_chatbot/features/login/data/datasources/login_datasource_impl.dart';
import 'package:lara_chatbot/features/login/data/repositories/login_repository_impl.dart';
import 'package:lara_chatbot/features/login/domain/usecases/email_and_password_login_usecase.dart';
import 'package:lara_chatbot/features/login/domain/usecases/google_sign_in_usecase.dart';
import 'package:lara_chatbot/features/login/domain/usecases/validate_email_usecase.dart';
import 'package:lara_chatbot/features/login/domain/usecases/validate_password_usecase.dart';
import 'package:lara_chatbot/features/login/presentation/getx_login_controller.dart';
import 'package:lara_chatbot/features/login/presentation/login_screen.dart';
import 'package:lara_chatbot/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = Directory.systemTemp.path;
  Hive
    ..init(path)
    ..openBox('lara_chat');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      theme: ThemeData(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ),
      ),
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(
            controller: GetxLoginController(
              validateEmailUsecase: ValidateEmailUsecase(),
              validatePasswordUsecase: ValidatePasswordUsecase(),
              emailAndPasswordLoginUsecase: EmailAndPasswordLoginUsecase(),
              googleSignInUsecase: GoogleSignInUsecase(
                LoginRepositoryImpl(LoginDatasourceImpl(GoogleSignIn.instance)),
              ),
            ),
          ),
        ),
        GetPage(
          name: '/dashboard',
          page: () => DashboardScreen(
            controller: GetxDashboardController(
              getMessageListUsecase: GetMessageListUsecase(
                DashboardRepoditoryImpl(
                  DashboardDatasourceImpl(Hive.box('lara_chat')),
                ),
              ),
              saveMessageListUsecase: SaveMessageListUsecase(
                DashboardRepoditoryImpl(
                  DashboardDatasourceImpl(Hive.box('lara_chat')),
                ),
              ),
            ),
          ),
        ),
        GetPage(
          name: '/chat',
          page: () {
            final argument = Get.arguments;
            return ChatScreen(history: argument?['history']);
          },
        ),
      ],
    );
  }
}
