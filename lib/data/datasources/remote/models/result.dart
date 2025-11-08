import 'network_error.dart';

abstract class Result<T> {
  final T? data;

  Result._(this.data);

  factory Result.error({required NetworkError error, T? data}) =>
      Error<T>(data, error);

  factory Result.success(T? data) => Success<T>(data);

  bool get isSuccess => this is Success<T>;

  Success<T> get asSuccess => this as Success<T>;

  Error<T> get asError => this as Error<T>;

  void handle({
    required void Function(T? response) onSuccess,
    required void Function(NetworkError error) onError,
  }) {
    switch (this) {
      case Success<T>():
        onSuccess((this as Success<T>).data);
        break;
      case Error<T>():
        onError((this as Error<T>).error);
        break;
    }
  }
}

class Error<T> extends Result<T> {
  final NetworkError error;

  Error(super.data, this.error) : super._();
}

class Success<T> extends Result<T> {
  Success(super.data) : super._();
}
