import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/features/shopping_feature/domain/usecases/shopping_usecase.dart';
import 'package:shopping_app/features/shopping_feature/domain/usecases/shopping_usecase_provider.dart';
import 'package:shopping_app/features/shopping_feature/presentation/providers/shopping_providers.dart';

import '../../domain/entities/shopping_get_items_entity_test.dart';

class MockShoppingUseCase extends Mock implements ShoppingUsecase {}

void main() {
  late MockShoppingUseCase mockUseCase;
  late ProviderContainer container;

  setUp(() {
    mockUseCase = MockShoppingUseCase();
    container = ProviderContainer(
      overrides: [shoppingUseCaseProvider.overrideWithValue(mockUseCase)],
    );
    addTearDown(container.dispose);
  });

  group('Initial State', () {
    test('should start with an empty list and isCheckoutSuccess as false', () {
      final state = container.read(shoppingCartProvider);
      expect(state.items, isEmpty);
      expect(state.isCheckoutSuccess, isFalse);
    });
  });

  group('addToCart', () {
    test('should add a new item to the cart', () {
      container.read(shoppingCartProvider.notifier).addToCart(item: expectProductItemEntity);

      final state = container.read(shoppingCartProvider);
      expect(state.items.length, 1);
      expect(state.items.first.cartItem.itemId, expectProductItemEntity.itemId);
      expect(state.items.first.amount, 1);
    });

    test('should increase amount if the same item is added again', () {
      final notifier = container.read(shoppingCartProvider.notifier);

      notifier.addToCart(item: expectProductItemEntity);
      notifier.addToCart(item: expectProductItemEntity);

      final state = container.read(shoppingCartProvider);

      expect(state.items.length, 1);
      expect(state.items.first.amount, 2);
    });
  });

  group('decreaseAmount', () {
    test('should decrease amount when current amount > 1', () {
      final notifier = container.read(shoppingCartProvider.notifier);
      notifier.addToCart(item: expectProductItemEntity);
      notifier.addToCart(item: expectProductItemEntity);

      notifier.decreaseAmount(itemId: expectProductItemEntity.itemId);

      expect(container.read(shoppingCartProvider).items.first.amount, 1);
    });

    test('should remove item entirely when decreasing from 1', () {
      final notifier = container.read(shoppingCartProvider.notifier);
      notifier.addToCart(item: expectProductItemEntity);

      notifier.decreaseAmount(itemId: expectProductItemEntity.itemId);

      expect(container.read(shoppingCartProvider).items, isEmpty);
    });
  });

  group('increaseAmount', () {
    test('should increase amount', () {
      final notifier = container.read(shoppingCartProvider.notifier);
      notifier.addToCart(item: expectProductItemEntity);

      notifier.increaseAmount(itemId: expectProductItemEntity.itemId);

      expect(container.read(shoppingCartProvider).items.first.amount, 2);
    });
  });

  group('checkout', () {
    test('should clear cart and set isCheckoutSuccess to true on success', () async {
      container.read(shoppingCartProvider.notifier).addToCart(item: expectProductItemEntity);

      when(() => mockUseCase.checkOut(body: any(named: 'body'))).thenAnswer((_) async => {});

      await container.read(shoppingCartProvider.notifier).checkout();

      final state = container.read(shoppingCartProvider);
      expect(state.items, isEmpty);
      expect(state.isCheckoutSuccess, true);
      verify(() => mockUseCase.checkOut(body: any(named: 'body'))).called(1);
    });

    test('should rethrow error if checkout fails', () async {
      when(() => mockUseCase.checkOut(body: any(named: 'body'))).thenThrow(Exception('Failed'));

      expect(
        () => container.read(shoppingCartProvider.notifier).checkout(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('deleteItemFromCart', () {
    test('should delete item from cart on success', () async {
      container.read(shoppingCartProvider.notifier).addToCart(item: expectProductItemEntity);
      container
          .read(shoppingCartProvider.notifier)
          .deleteItemFromCart(itemId: expectProductItemEntity.itemId);

      expect(container.read(shoppingCartProvider).items, isEmpty);
    });
  });
}
