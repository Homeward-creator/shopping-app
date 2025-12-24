import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_app/features/shopping_feature/domain/entities/shopping_get_items_entity.dart';

import '../../../../mocks/mock_data.dart';

final expectProductItemEntity = ProductItemEntity(
  itemId: expectString,
  itemName: expectString,
  itemPrice: expectInt,
);

final expectShoppingGetItemsBodyEntity = ShoppingGetItemsBodyEntity(
  cursor: expectString,
  limit: expectInt,
);

final expectShoppingItemsResponseEntity = ShoppingItemsResponseEntity(
  items: [expectProductItemEntity],
  cursor: expectString,
);

void main() {
  group('ShoppingGetItemsBodyEntity class', () {
    test('Should have ShoppingGetItemsBodyEntity Class', () {
      expect(ShoppingGetItemsBodyEntity, ShoppingGetItemsBodyEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectShoppingGetItemsBodyEntity.cursor, expectString);
      expect(expectShoppingGetItemsBodyEntity.limit, expectInt);
    });

    test('Should return correct hashCode', () {
      final ShoppingGetItemsBodyEntity instance = expectShoppingGetItemsBodyEntity;
      expect(instance.hashCode, instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props));
    });
  });

  group('ShoppingItemsResponseEntity class', () {
    test('Should have ShoppingItemsResponseEntity Class', () {
      expect(ShoppingItemsResponseEntity, ShoppingItemsResponseEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectShoppingItemsResponseEntity.cursor, expectString);
      expect(expectShoppingItemsResponseEntity.items.first.itemId, expectProductItemEntity.itemId);
      expect(
        expectShoppingItemsResponseEntity.items.first.itemName,
        expectProductItemEntity.itemName,
      );
      expect(
        expectShoppingItemsResponseEntity.items.first.itemPrice,
        expectProductItemEntity.itemPrice,
      );
    });

    test('Should return correct hashCode', () {
      final ShoppingItemsResponseEntity instance = expectShoppingItemsResponseEntity;
      expect(instance.hashCode, instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props));
    });
  });

  group('ProductItemEntity class', () {
    test('Should have ProductItemEntity Class', () {
      expect(ProductItemEntity, ProductItemEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectProductItemEntity.itemId, expectString);
      expect(expectProductItemEntity.itemName, expectString);
      expect(expectProductItemEntity.itemPrice, expectInt);
    });

    test('Should return correct hashCode', () {
      final ProductItemEntity instance = expectProductItemEntity;
      expect(instance.hashCode, instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props));
    });
  });
}
