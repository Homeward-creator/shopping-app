import '../models/shopping_cart_datasource_model.dart';
import '../models/shopping_get_items_datasource_model.dart';
import '../models/shopping_get_recommended_items_datasource_model.dart';

abstract class ShoppingRestfulDatasource {
  Future<ShoppingItemsResponseDatasourceModel> getItems({
    required ShoppingGetItemsBodyDatasourceModel requestBody,
  });

  Future<ShoppingRecommendedItemsResponseDatasourceModel> getRecommendedItems();

  Future<void> checkOut({required List<ShoppingCartDatasourceModel> body});
}
