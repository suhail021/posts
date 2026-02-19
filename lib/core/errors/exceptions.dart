class serverException implements Exception {
  final String message;

  serverException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class cacheException implements Exception {
  final String message;

  cacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
} 
class networkException implements Exception {
  final String message;

  networkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}
 
class unknownException implements Exception {
  final String message;

  unknownException(this.message);

  @override
  String toString() => 'UnknownException: $message';
}

class validationException implements Exception {
  final String message;

  validationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}