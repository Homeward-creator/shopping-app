import 'package:equatable/equatable.dart';

class ShoppingGetItemsBodyEntity extends Equatable {
  const ShoppingGetItemsBodyEntity({required String? cursor, required int? limit})
    : _cursor = cursor,
      _limit = limit;

  final String? _cursor;
  final int? _limit;

  String? get cursor => _cursor;

  int? get limit => _limit;

  @override
  List<Object?> get props => <Object?>[_cursor, _limit];
}

class ShoppingItemsResponseEntity extends Equatable {
  const ShoppingItemsResponseEntity({
    required List<ProductItemEntity> items,
    required String? cursor,
  }) : _items = items,
       _cursor = cursor;

  final List<ProductItemEntity> _items;
  final String? _cursor;

  List<ProductItemEntity> get items => _items;

  String? get cursor => _cursor;

  @override
  List<Object?> get props => <Object?>[_items, _cursor];

  ShoppingItemsResponseEntity copyWith({
    required List<ProductItemEntity>? items,
    required String? cursor,
  }) {
    return ShoppingItemsResponseEntity(items: items ?? this.items, cursor: cursor ?? this.cursor);
  }
}

class ProductItemEntity extends Equatable {
  const ProductItemEntity({
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

  @override
  List<Object> get props => <Object>[_itemId, _itemName, _itemPrice];
}
