import 'package:equatable/equatable.dart';

import 'shopping_get_items_entity.dart';

class ShoppingCartEntity extends Equatable {
  const ShoppingCartEntity({required int amount, required ProductItemEntity cartItem})
    : _amount = amount,
      _cartItem = cartItem;

  final int _amount;
  final ProductItemEntity _cartItem;

  int get amount => _amount;

  ProductItemEntity get cartItem => _cartItem;

  ShoppingCartEntity copyWith({required int? amount, required ProductItemEntity? cartItem}) {
    return ShoppingCartEntity(amount: amount ?? this.amount, cartItem: cartItem ?? this.cartItem);
  }

  @override
  List<Object> get props => <Object>[_amount, _cartItem];
}
