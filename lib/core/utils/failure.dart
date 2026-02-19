sealed class Failure {
  final String message;

  const Failure(this.message);
}

class WrongEmailFailure implements Failure {
  @override
  String get message => 'O Email está incorreto';
}

class WrongPasswordFailure implements Failure {
  @override
  String get message => 'A Senha está incorreto';
}
