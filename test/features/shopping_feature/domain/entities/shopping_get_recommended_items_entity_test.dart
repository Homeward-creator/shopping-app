import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_app/features/shopping_feature/domain/entities/shopping_get_recommended_items_entity.dart';

import 'shopping_get_items_entity_test.dart';

final expectShoppingRecommendedItemsResponseEntity = ShoppingRecommendedItemsResponseEntity(
  items: [expectProductItemEntity],
);

void main() {
  group('ShoppingRecommendedItemsResponseEntity class', () {
    test('Should have ShoppingRecommendedItemsResponseEntity Class', () {
      expect(ShoppingRecommendedItemsResponseEntity, ShoppingRecommendedItemsResponseEntity);
    });

    test('Should have mandatory properties', () {
      expect(
        expectShoppingRecommendedItemsResponseEntity.items.first.itemId,
        expectProductItemEntity.itemId,
      );
      expect(
        expectShoppingRecommendedItemsResponseEntity.items.first.itemName,
        expectProductItemEntity.itemName,
      );
      expect(
        expectShoppingRecommendedItemsResponseEntity.items.first.itemPrice,
        expectProductItemEntity.itemPrice,
      );
    });

    test('Should return correct hashCode', () {
      final ShoppingRecommendedItemsResponseEntity instance =
          expectShoppingRecommendedItemsResponseEntity;
      expect(instance.hashCode, instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props));
    });
  });
}
