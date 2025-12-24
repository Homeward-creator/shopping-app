import '../../configs/error/error_usecase_config.dart';
import '../entities/shopping_cart_entity.dart';
import '../entities/shopping_get_items_entity.dart';
import '../entities/shopping_get_recommended_items_entity.dart';
import '../repositories/shopping_repository.dart';

import 'shopping_usecase.dart';

class ShoppingUsecaseImpl extends ShoppingUsecase {
  ShoppingUsecaseImpl({required ShoppingRepository repository}) : _repository = repository;

  final ShoppingRepository _repository;

  ShoppingRepository get repository => _repository;
  @override
  Future<ShoppingItemsResponseEntity> getItems({
    required ShoppingGetItemsBodyEntity requestBody,
  }) async {
    try {
      return await _repository.getItems(requestBody: requestBody);
    } catch (e) {
      throw ShoppingGetItemUsecaseError(message: e.toString());
    }
  }

  @override
  Future<ShoppingRecommendedItemsResponseEntity> getRecommendedItems() async {
    try {
      return await _repository.getRecommendedItems();
    } catch (e) {
      throw ShoppingGetRecommendedItemUsecaseError(message: e.toString());
    }
  }

  @override
  Future<void> checkOut({required List<ShoppingCartEntity> body}) async {
    try {
      return await _repository.checkOut(body: body);
    } catch (e) {
      throw ShoppingCheckOutUsecaseError(message: e.toString());
    }
  }
}
