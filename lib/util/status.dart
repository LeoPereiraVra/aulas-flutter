sealed class Status<T> {
  const Status();
  
  const factory Status.carregando(String message) = Carregando._;
  
  const factory Status.success(T value) = Success._;

  const factory Status.error(String value) = Erro._;

  const factory Status.nome() = Nome._;
  
}

final class Carregando<T> extends Status<T> {
  const Carregando._(this.message);


  final String message;

  @override
  String toString() => message;
}

final class Erro<T> extends Status<T> {
  const Erro._(this.exception);


  final String exception;

  @override
  String toString() => exception;
}

final class Success<T> extends Status<T> {
  const Success._(this.value);
  final T value;

  @override
  String toString() => '$value';
}

final class Nome<T> extends Status<T> {
  const Nome._();
}