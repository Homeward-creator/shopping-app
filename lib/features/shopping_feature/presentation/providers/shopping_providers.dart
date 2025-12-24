import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/shopping_get_items_entity.dart';
import '../../domain/entities/shopping_get_recommended_items_entity.dart';
import '../viewmodels/shopping_cart_view_model.dart';
import '../viewmodels/shopping_get_items_view_model.dart';
import '../viewmodels/shopping_get_recommended_items_view_model.dart';

import 'shopping_cart_state.dart';

final shoppingGetRecommendedItemsProvider =
    AsyncNotifierProvider<
      ShoppingGetRecommendedItemsViewModel,
      ShoppingRecommendedItemsResponseEntity
    >(() {
      return ShoppingGetRecommendedItemsViewModel();
    });

final shoppingGetItemsProvider =
    AsyncNotifierProvider<ShoppingGetItemsViewModel, ShoppingItemsResponseEntity>(() {
      return ShoppingGetItemsViewModel();
    });

final shoppingCartProvider = NotifierProvider<ShoppingCartViewModel, ShoppingCartState>(() {
  return ShoppingCartViewModel();
});

final shoppingCartTotalAmountProvider = Provider<double>((ref) {
  final cartItems = ref.watch(shoppingCartProvider);

  return cartItems.items.fold(0.0, (sum, item) {
    return sum + (item.cartItem.itemPrice * item.amount);
  });
});

final shoppingCartResultAmountProvider = Provider<double>((ref) {
  final cartItems = ref.watch(shoppingCartProvider);

  return cartItems.items.fold(0.0, (total, item) {
    final double price = item.cartItem.itemPrice.toDouble();
    final int amount = item.amount;
    int pairs = amount ~/ 2;
    int leftovers = amount % 2;
    double priceForPairs = (pairs * 2 * price) * 0.95;
    double priceForLeftovers = leftovers * price;

    return total + priceForPairs + priceForLeftovers;
  });
});

final cartSavingsProvider = Provider<double>((ref) {
  final cartItems = ref.watch(shoppingCartProvider);

  return cartItems.items.fold(0.0, (savings, item) {
    int pairs = item.amount ~/ 2;
    // Each pair saves 5% of the cost of 2 items
    double savingPerPair = (2 * item.cartItem.itemPrice) * 0.05;
    return savings + (pairs * savingPerPair);
  });
});

final checkoutSuccessProvider = StateProvider<bool>((ref) => false);
