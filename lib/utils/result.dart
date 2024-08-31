class Result<T> {
  final T? _success;
  final String? _error;

  const Result.success(this._success) : _error = null;
  const Result.error(this._error) : _success = null;

  bool get isSuccess => _success != null;
  bool get isError => _error != null;

  T get success => _success!;
  String get error => _error!;
}
