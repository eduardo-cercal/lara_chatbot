sealed class BaseUsecase<Input> {
  dynamic execute([Input? input]);
}

abstract class Usecase<Output, Input> implements BaseUsecase<Input> {
  @override
  Output execute([Input? intput]);
}

abstract class FutureUsecase<Output, Input> implements BaseUsecase<Input> {
  @override
  Future<Output> execute([Input? input]);
}

abstract class StreamUsecase<Output, Input> implements BaseUsecase<Input> {
  @override
  Stream<Output> execute([Input? input]);
}
