import '../entities/shopping_cart_entity.dart';
import '../entities/shopping_get_items_entity.dart';
import '../entities/shopping_get_recommended_items_entity.dart';

abstract class ShoppingUsecase {
  Future<ShoppingItemsResponseEntity> getItems({required ShoppingGetItemsBodyEntity requestBody});

  Future<ShoppingRecommendedItemsResponseEntity> getRecommendedItems();

  Future<void> checkOut({required List<ShoppingCartEntity> body});
}
