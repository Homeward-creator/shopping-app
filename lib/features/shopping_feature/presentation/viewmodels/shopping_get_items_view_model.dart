import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shopping_get_items_entity.dart';
import '../../domain/usecases/shopping_usecase_provider.dart';

class ShoppingGetItemsViewModel extends AsyncNotifier<ShoppingItemsResponseEntity> {
  @override
  FutureOr<ShoppingItemsResponseEntity> build() {
    return _fetchItems(cursor: null, limit: 20);
  }

  Future<ShoppingItemsResponseEntity> _fetchItems({
    required String? cursor,
    required int? limit,
  }) async {
    final useCase = ref.read(shoppingUseCaseProvider);
    return await useCase.getItems(
      requestBody: ShoppingGetItemsBodyEntity(cursor: cursor, limit: limit ?? 5),
    );
  }

  Future<void> getProductItems({required ShoppingGetItemsBodyEntity body}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchItems(cursor: body.cursor, limit: body.limit));
  }

  Future<void> fetchNextPage() async {
    if (state.isLoading || state.value?.cursor == null) return;

    final previousData = state.value!;

    state = await AsyncValue.guard(() async {
      final nextResponse = await _fetchItems(cursor: previousData.cursor, limit: null);

      return nextResponse.copyWith(
        items: [...previousData.items, ...nextResponse.items],
        cursor: null,
      );
    });
  }
}
