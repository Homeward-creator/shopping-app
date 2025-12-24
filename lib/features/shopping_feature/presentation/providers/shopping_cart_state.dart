import '../../domain/entities/shopping_cart_entity.dart';

class ShoppingCartState {
  const ShoppingCartState({required this.items, this.isCheckoutSuccess = false});

  final List<ShoppingCartEntity> items;
  final bool isCheckoutSuccess;

  ShoppingCartState copyWith({List<ShoppingCartEntity>? items, required bool? isCheckoutSuccess}) {
    return ShoppingCartState(
      items: items ?? this.items,
      isCheckoutSuccess: isCheckoutSuccess ?? this.isCheckoutSuccess,
    );
  }
}
