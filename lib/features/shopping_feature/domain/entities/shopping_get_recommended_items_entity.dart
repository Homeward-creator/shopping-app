import 'package:equatable/equatable.dart';

import 'shopping_get_items_entity.dart';

class ShoppingRecommendedItemsResponseEntity extends Equatable {
  const ShoppingRecommendedItemsResponseEntity({required List<ProductItemEntity> items})
    : _items = items;

  final List<ProductItemEntity> _items;

  List<ProductItemEntity> get items => _items;

  @override
  List<Object> get props => <Object>[_items];
}
