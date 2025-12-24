import '../../../../configs/error_config/error_config.dart';

import 'error_config.dart';

class ShoppingGetItemRepositoryError extends ErrorConfig {
  ShoppingGetItemRepositoryError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetItemRepositoryError: $_message''';
}

class ShoppingGetRecommendedItemRepositoryError extends ErrorConfig {
  ShoppingGetRecommendedItemRepositoryError({required String message}) : _message = message;

  final String _message;

  @override
  String get message => _message;

  @override
  String toString() => '''$shoppingGetRecommendedItemRepositoryError: $_message''';
}
