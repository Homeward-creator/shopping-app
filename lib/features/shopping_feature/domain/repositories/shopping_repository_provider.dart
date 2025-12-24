import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/shopping_restful_service_provider.dart';

import 'shopping_repository.dart';
import 'shopping_repository_impl.dart';

final shoppingRepositoryProvider = Provider<ShoppingRepository>((ref) {
  final dataSource = ref.watch(shoppingRestfulServiceProvider);
  return ShoppingRepositoryImpl(restfulDatasource: dataSource);
});
