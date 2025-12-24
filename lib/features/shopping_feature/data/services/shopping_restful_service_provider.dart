import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/shopping_datasource.dart';

import 'shopping_restful_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final shoppingRestfulServiceProvider = Provider<ShoppingRestfulDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return ShoppingRestfulService(http: dio);
});
