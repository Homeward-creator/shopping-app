import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shopping_cart_entity.dart';
import '../../domain/entities/shopping_get_items_entity.dart';
import '../../domain/usecases/shopping_usecase_provider.dart';
import '../providers/shopping_cart_state.dart';

class ShoppingCartViewModel extends Notifier<ShoppingCartState> {
  @override
  ShoppingCartState build() {
    return const ShoppingCartState(items: <ShoppingCartEntity>[]);
  }

  void resetCheckoutStatus() {
    state = state.copyWith(isCheckoutSuccess: false);
  }

  Future<void> checkout() async {
    final useCase = ref.read(shoppingUseCaseProvider);

    try {
      await useCase.checkOut(body: state.items);

      state = state.copyWith(items: const [], isCheckoutSuccess: true);
    } catch (e) {
      rethrow;
    }
  }

  void addToCart({required ProductItemEntity item}) {
    final List<ShoppingCartEntity> currentItems = List.from(state.items);
    final int existingIndex = currentItems.indexWhere(
      (element) => element.cartItem.itemId == item.itemId,
    );

    if (existingIndex != -1) {
      currentItems[existingIndex] = currentItems[existingIndex].copyWith(
        amount: currentItems[existingIndex].amount + 1,
        cartItem: null,
      );
    } else {
      currentItems.add(ShoppingCartEntity(amount: 1, cartItem: item));
    }

    state = state.copyWith(items: currentItems, isCheckoutSuccess: false);
  }

  void deleteItemFromCart({required String itemId}) {
    final updatedItems = state.items.where((item) => item.cartItem.itemId != itemId).toList();

    state = state.copyWith(items: updatedItems, isCheckoutSuccess: false);
  }

  void decreaseAmount({required String itemId}) {
    final int index = state.items.indexWhere((element) => element.cartItem.itemId == itemId);

    if (index == -1) return;

    final ShoppingCartEntity existingItem = state.items[index];

    if (existingItem.amount > 1) {
      final ShoppingCartEntity updatedItem = existingItem.copyWith(
        amount: existingItem.amount - 1,
        cartItem: null,
      );
      final List<ShoppingCartEntity> newList = List<ShoppingCartEntity>.from(state.items);

      newList[index] = updatedItem;
      state = state.copyWith(items: newList, isCheckoutSuccess: false);
    } else {
      state = state.copyWith(
        items: state.items.where((item) => item.cartItem.itemId != itemId).toList(),
        isCheckoutSuccess: false,
      );
    }
  }

  void increaseAmount({required String itemId}) {
    final int index = state.items.indexWhere((element) => element.cartItem.itemId == itemId);

    if (index == -1) return;

    final ShoppingCartEntity existingItem = state.items[index];
    final ShoppingCartEntity updatedItem = existingItem.copyWith(
      amount: existingItem.amount + 1,
      cartItem: null,
    );
    final List<ShoppingCartEntity> newList = List<ShoppingCartEntity>.from(state.items);

    newList[index] = updatedItem;
    state = state.copyWith(items: newList, isCheckoutSuccess: false);
  }
}
