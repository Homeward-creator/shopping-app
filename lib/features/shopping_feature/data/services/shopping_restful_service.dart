import 'package:dio/dio.dart';

import '../../../../configs/api_config/api_config.dart';
import '../../configs/api_config/api_config.dart';
import '../../configs/error/error_restful_service_config.dart';
import '../datasources/shopping_datasource.dart';
import '../models/shopping_cart_datasource_model.dart';
import '../models/shopping_get_items_datasource_model.dart';
import '../models/shopping_get_recommended_items_datasource_model.dart';

class ShoppingRestfulService extends ShoppingRestfulDatasource {
  ShoppingRestfulService({required Dio http}) : _http = http;

  final Dio _http;

  Dio get http => _http;

  @override
  Future<ShoppingItemsResponseDatasourceModel> getItems({
    required ShoppingGetItemsBodyDatasourceModel requestBody,
  }) async {
    try {
      //NOTE?: In web will have CORS blocked if run localhost
      final Response<dynamic> response = await _http.get(
        '$baseUrl$shoppingGetProductItemsPath',
        queryParameters: requestBody.toMapString(),
      );

      return ShoppingItemsResponseDatasourceModel.fromJson(response.data);
    } catch (e) {
      throw ShoppingGetItemServiceError(message: e.toString());
    }
  }

  @override
  Future<ShoppingRecommendedItemsResponseDatasourceModel> getRecommendedItems() async {
    try {
      final Response<dynamic> response = await _http.get(
        '$baseUrl$shoppingGetRecommendedProductItemsPath',
      );
      final List<dynamic> rawData = response.data;

      return ShoppingRecommendedItemsResponseDatasourceModel(
        items: rawData.map((item) => ProductItemsDataSourceModel.fromJson(item)).toList(),
      );
    } catch (e) {
      throw ShoppingGetRecommendedItemServiceError(message: e.toString());
    }
  }

  @override
  Future<void> checkOut({required List<ShoppingCartDatasourceModel> body}) async {
    try {
      // NOTE: case error
      // await _http.get('${baseUrl}checkout');
      // NOTE: case success
      await _http.post(
        '$baseUrl$shoppingCheckOutPath',
        data: {
          'products': [1],
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } catch (e) {
      throw ShoppingCheckOutServiceError(message: e.toString());
    }
  }
}
