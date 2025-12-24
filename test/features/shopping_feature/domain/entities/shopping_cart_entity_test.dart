import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_app/features/shopping_feature/domain/entities/shopping_cart_entity.dart';

import '../../../../mocks/mock_data.dart';

import 'shopping_get_items_entity_test.dart';

final expectShoppingCartEntity = ShoppingCartEntity(
  amount: expectInt,
  cartItem: expectProductItemEntity,
);

void main() {
  group('ShoppingCartEntity class', () {
    test('Should have ShoppingCartEntity Class', () {
      expect(ShoppingCartEntity, ShoppingCartEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectShoppingCartEntity.amount, expectInt);
      expect(expectShoppingCartEntity.cartItem.itemId, expectProductItemEntity.itemId);
      expect(expectShoppingCartEntity.cartItem.itemName, expectProductItemEntity.itemName);
      expect(expectShoppingCartEntity.cartItem.itemPrice, expectProductItemEntity.itemPrice);
    });

    test('Should return correct hashCode', () {
      final ShoppingCartEntity instance = expectShoppingCartEntity;
      expect(instance.hashCode, instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props));
    });
  });
}
