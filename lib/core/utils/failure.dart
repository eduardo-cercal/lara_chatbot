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

class EmptyEmailFailure implements Failure {
  @override
  String get message => 'Email não pode estar em branco';
}

class IsNotEmailFailure implements Failure {
  @override
  String get message => 'Esse campo precisa ser uma email';
}

class InvaildLengthFaiure implements Failure {
  @override
  String get message => 'A senha deve conter pelo menos 6 caracteres';
}

class GenericFailure implements Failure {
  final String? _message;

  GenericFailure(this._message);

  @override
  String get message => _message ?? 'Algo inesperado ocorreu, tente novamente';
}
