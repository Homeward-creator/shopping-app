import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/theme_config/theme_config.dart';
import '../../domain/entities/shopping_get_items_entity.dart';
import '../providers/shopping_providers.dart';

class ShoppingItemCard extends StatelessWidget {
  const ShoppingItemCard({
    super.key,
    required String itemId,
    required String itemName,
    required int itemPrice,
  }) : _itemId = itemId,
       _itemName = itemName,
       _itemPrice = itemPrice;

  final String _itemId;
  final String _itemName;
  final int _itemPrice;

  String get itemId => _itemId;

  String get itemName => _itemName;

  int get itemPrice => _itemPrice;

  Widget _itemImage() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
      width: 76,
      height: 76,
    );
  }

  Widget _itemNameAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_itemName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text('$_itemPrice / unit'),
        ],
      ),
    );
  }

  Widget _buttons({required WidgetRef ref}) {
    final shoppingCart = ref.watch(shoppingCartProvider);
    final shoppingCartNotifier = ref.read(shoppingCartProvider.notifier);
    final isItemAlreadyInCart = shoppingCart.items.any((item) => item.cartItem.itemId == _itemId);

    return isItemAlreadyInCart
        ? Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outlined, color: PrimaryTheme.color.primary),
                onPressed: () => shoppingCartNotifier.decreaseAmount(itemId: _itemId),
              ),
              Text(
                (shoppingCart.items
                            .firstWhereOrNull((item) => item.cartItem.itemId == _itemId)
                            ?.amount ??
                        0)
                    .toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outlined),
                onPressed: () => shoppingCartNotifier.increaseAmount(itemId: _itemId),
              ),
            ],
          )
        : ElevatedButton(
            onPressed: () {
              shoppingCartNotifier.addToCart(
                item: ProductItemEntity(
                  itemId: _itemId,
                  itemName: _itemName,
                  itemPrice: _itemPrice,
                ),
              );
            },
            child: Text('Add to cart'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return SizedBox(
          height: 76,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_itemImage(), _itemNameAndPrice()],
                ),
                _buttons(ref: ref),
              ],
            ),
          ),
        );
      },
    );
  }
}
