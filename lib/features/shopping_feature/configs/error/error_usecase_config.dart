import '../../../../configs/error_config/error_config.dart';

import 'error_config.dart';

class ShoppingGetItemUsecaseError extends ErrorConfig {
  ShoppingGetItemUsecaseError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetItemUsecaseError: $_message''';
}

class ShoppingGetRecommendedItemUsecaseError extends ErrorConfig {
  ShoppingGetRecommendedItemUsecaseError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetRecommendedItemUsecaseError: $_message''';
}

class ShoppingCheckOutUsecaseError extends ErrorConfig {
  ShoppingCheckOutUsecaseError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetRecommendedItemUsecaseError: $_message''';
}
