import 'package:lara_chatbot/core/interfaces/domain/entity.dart';

class EmailAndPasswordEntity extends Entity {
  final String email;
  final String password;

  EmailAndPasswordEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
