import '../../domain/entities/shopping_get_items_entity.dart';

class ShoppingGetItemsBodyDatasourceModel extends ShoppingGetItemsBodyEntity {
  const ShoppingGetItemsBodyDatasourceModel({required super.cursor, super.limit});

  Map<String, dynamic> toMapString() => <String, dynamic>{'cursor': cursor, 'limit': limit};
}

class ShoppingItemsResponseDatasourceModel extends ShoppingItemsResponseEntity {
  factory ShoppingItemsResponseDatasourceModel.fromJson(Map<String, dynamic> json) {
    return ShoppingItemsResponseDatasourceModel(
      items: (json['items'] as List)
          .map((i) => ProductItemsDataSourceModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      cursor: (json['nextCursor'] as String),
    );
  }
  const ShoppingItemsResponseDatasourceModel({
    required List<ProductItemsDataSourceModel> items,
    required super.cursor,
  }) : _items = items,
       super(items: items);

  final List<ProductItemsDataSourceModel> _items;

  @override
  List<ProductItemsDataSourceModel> get items => _items;
}

class ProductItemsDataSourceModel extends ProductItemEntity {
  const ProductItemsDataSourceModel({
    required super.itemId,
    required super.itemName,
    required super.itemPrice,
  });

  factory ProductItemsDataSourceModel.fromJson(Map<String, dynamic> json) {
    return ProductItemsDataSourceModel(
      itemId: '${(json['id'] as int)}${json['name'] as String}',
      itemName: json['name'] as String,
      itemPrice: json['price'] as int,
    );
  }
}
