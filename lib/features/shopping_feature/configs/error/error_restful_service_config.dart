import '../../../../configs/error_config/error_config.dart';

import 'error_config.dart';

class ShoppingGetItemServiceError extends ErrorConfig {
  ShoppingGetItemServiceError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetItemServiceError: $_message''';
}

class ShoppingGetRecommendedItemServiceError extends ErrorConfig {
  ShoppingGetRecommendedItemServiceError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetRecommendedItemServiceError: $_message''';
}

class ShoppingCheckOutServiceError extends ErrorConfig {
  ShoppingCheckOutServiceError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingCheckOutServiceError: $_message''';
}
