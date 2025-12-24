import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shopping_get_recommended_items_entity.dart';
import '../../domain/usecases/shopping_usecase_provider.dart';

class ShoppingGetRecommendedItemsViewModel
    extends AsyncNotifier<ShoppingRecommendedItemsResponseEntity> {
  @override
  FutureOr<ShoppingRecommendedItemsResponseEntity> build() async {
    return _fetchInitialRecommededItems();
  }

  Future<ShoppingRecommendedItemsResponseEntity> _fetchInitialRecommededItems() async {
    final useCase = ref.read(shoppingUseCaseProvider);
    return await useCase.getRecommendedItems();
  }

  Future<void> getRecommendedProductItems() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchInitialRecommededItems());
  }
}
