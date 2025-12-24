import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/shopping_repository_provider.dart';

import 'shopping_usecase.dart';
import 'shopping_usecase_impl.dart';

final shoppingUseCaseProvider = Provider<ShoppingUsecase>((ref) {
  final repo = ref.watch(shoppingRepositoryProvider);
  return ShoppingUsecaseImpl(repository: repo);
});
