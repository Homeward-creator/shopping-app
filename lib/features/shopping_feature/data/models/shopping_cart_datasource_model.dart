import '../../domain/entities/shopping_cart_entity.dart';

import 'shopping_get_items_datasource_model.dart';

class ShoppingCartDatasourceModel extends ShoppingCartEntity {
  const ShoppingCartDatasourceModel({
    required super.amount,
    required ProductItemsDataSourceModel cartItem,
  }) : _cartItem = cartItem,
       super(cartItem: cartItem);

  final ProductItemsDataSourceModel _cartItem;

  @override
  ProductItemsDataSourceModel get cartItem => _cartItem;
}
