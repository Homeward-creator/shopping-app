import '../../configs/error/error_repository_config.dart';
import '../../data/datasources/shopping_datasource.dart';
import '../../data/models/shopping_cart_datasource_model.dart';
import '../../data/models/shopping_get_items_datasource_model.dart';
import '../entities/shopping_cart_entity.dart';
import '../entities/shopping_get_items_entity.dart';
import '../entities/shopping_get_recommended_items_entity.dart';

import 'shopping_repository.dart';

class ShoppingRepositoryImpl extends ShoppingRepository {
  ShoppingRepositoryImpl({required ShoppingRestfulDatasource restfulDatasource})
    : _restfulDatasource = restfulDatasource;

  final ShoppingRestfulDatasource _restfulDatasource;

  ShoppingRestfulDatasource get restfulDatasource => _restfulDatasource;

  @override
  Future<ShoppingItemsResponseEntity> getItems({
    required ShoppingGetItemsBodyEntity requestBody,
  }) async {
    try {
      final response = await _restfulDatasource.getItems(
        requestBody: ShoppingGetItemsBodyDatasourceModel(
          cursor: requestBody.cursor,
          limit: requestBody.limit,
        ),
      );

      return ShoppingItemsResponseEntity(
        cursor: response.cursor,
        items: response.items
            .map(
              (item) => ProductItemEntity(
                itemId: item.itemId,
                itemName: item.itemName,
                itemPrice: item.itemPrice,
              ),
            )
            .toList(),
      );
    } catch (e) {
      throw ShoppingGetItemRepositoryError(message: e.toString());
    }
  }

  @override
  Future<ShoppingRecommendedItemsResponseEntity> getRecommendedItems() async {
    try {
      final response = await _restfulDatasource.getRecommendedItems();

      return ShoppingRecommendedItemsResponseEntity(
        items: response.items
            .map(
              (item) => ProductItemEntity(
                itemId: item.itemId,
                itemName: item.itemName,
                itemPrice: item.itemPrice,
              ),
            )
            .toList(),
      );
    } catch (e) {
      throw ShoppingGetRecommendedItemRepositoryError(message: e.toString());
    }
  }

  @override
  Future<void> checkOut({required List<ShoppingCartEntity> body}) async {
    try {
      await _restfulDatasource.checkOut(
        body: body
            .map(
              (item) => ShoppingCartDatasourceModel(
                amount: item.amount,
                cartItem: ProductItemsDataSourceModel(
                  itemId: item.cartItem.itemId,
                  itemName: item.cartItem.itemName,
                  itemPrice: item.cartItem.itemPrice,
                ),
              ),
            )
            .toList(),
      );
    } catch (e) {
      throw ShoppingGetRecommendedItemRepositoryError(message: e.toString());
    }
  }
}
