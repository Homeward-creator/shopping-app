import '../../domain/entities/shopping_get_recommended_items_entity.dart';

import 'shopping_get_items_datasource_model.dart';

class ShoppingRecommendedItemsResponseDatasourceModel
    extends ShoppingRecommendedItemsResponseEntity {
  factory ShoppingRecommendedItemsResponseDatasourceModel.fromJson(Map<String, dynamic> json) {
    return ShoppingRecommendedItemsResponseDatasourceModel(
      items: (json['items'] as List)
          .map((i) => ProductItemsDataSourceModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
  const ShoppingRecommendedItemsResponseDatasourceModel({
    required List<ProductItemsDataSourceModel> items,
  }) : _items = items,
       super(items: items);

  final List<ProductItemsDataSourceModel> _items;

  @override
  List<ProductItemsDataSourceModel> get items => _items;
}
