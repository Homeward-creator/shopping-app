import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/features/shopping_feature/configs/error/error_repository_config.dart';
import 'package:shopping_app/features/shopping_feature/data/datasources/shopping_datasource.dart';
import 'package:shopping_app/features/shopping_feature/data/models/shopping_get_items_datasource_model.dart';
import 'package:shopping_app/features/shopping_feature/data/models/shopping_get_recommended_items_datasource_model.dart';
import 'package:shopping_app/features/shopping_feature/domain/repositories/shopping_repository_impl.dart';

import '../entities/shopping_cart_entity_test.dart';
import '../entities/shopping_get_items_entity_test.dart';
import '../entities/shopping_get_recommended_items_entity_test.dart';

final expectProductItemsDataSourceModel = ProductItemsDataSourceModel(
  itemId: expectProductItemEntity.itemId,
  itemName: expectProductItemEntity.itemName,
  itemPrice: expectProductItemEntity.itemPrice,
);

final expectShoppingItemsResponseDatasourceModel = ShoppingItemsResponseDatasourceModel(
  items: [expectProductItemsDataSourceModel],
  cursor: expectShoppingItemsResponseEntity.cursor,
);

final expectShoppingGetItemsBodyDatasourceModel = ShoppingGetItemsBodyDatasourceModel(
  cursor: expectShoppingGetItemsBodyEntity.cursor,
);

final expectShoppingRecommendedItemsResponseDatasourceModel =
    ShoppingRecommendedItemsResponseDatasourceModel(items: [expectProductItemsDataSourceModel]);

class MockShoppingRestfulDatasource extends Mock implements ShoppingRestfulDatasource {}

class FakeShoppingGetItemsBodyDatasourceModel extends Fake
    implements ShoppingGetItemsBodyDatasourceModel {}

void main() {
  late ShoppingRepositoryImpl repository;
  late MockShoppingRestfulDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(FakeShoppingGetItemsBodyDatasourceModel());
  });

  setUp(() {
    mockDatasource = MockShoppingRestfulDatasource();
    repository = ShoppingRepositoryImpl(restfulDatasource: mockDatasource);
  });

  group('getItems', () {
    test('should return ShoppingItemsResponseEntity when the call is successful', () async {
      when(
        () => mockDatasource.getItems(requestBody: any(named: 'requestBody')),
      ).thenAnswer((_) async => expectShoppingItemsResponseDatasourceModel);

      final result = await repository.getItems(requestBody: expectShoppingGetItemsBodyEntity);

      expect(result, equals(expectShoppingItemsResponseEntity));
      verify(() => mockDatasource.getItems(requestBody: any(named: 'requestBody'))).called(1);
    });

    test(
      'should throw ShoppingGetItemRepositoryError when the datasource throws an exception',
      () async {
        when(
          () => mockDatasource.getItems(requestBody: any(named: 'requestBody')),
        ).thenThrow(Exception('Network Error'));

        expect(
          () => repository.getItems(requestBody: expectShoppingGetItemsBodyEntity),
          throwsA(isA<ShoppingGetItemRepositoryError>()),
        );
      },
    );
  });

  group('getRecommendedItems', () {
    test(
      'should return ShoppingRecommendedItemsResponseEntity when the call is successful',
      () async {
        when(
          () => mockDatasource.getRecommendedItems(),
        ).thenAnswer((_) async => expectShoppingRecommendedItemsResponseDatasourceModel);

        final result = await repository.getRecommendedItems();

        expect(result, equals(expectShoppingRecommendedItemsResponseEntity));
        verify(() => mockDatasource.getRecommendedItems()).called(1);
      },
    );

    test(
      'should throw ShoppingGetRecommendedItemRepositoryError when the datasource throws an exception',
      () async {
        when(() => mockDatasource.getRecommendedItems()).thenThrow(Exception('Network Error'));

        expect(
          () => repository.getRecommendedItems(),
          throwsA(isA<ShoppingGetRecommendedItemRepositoryError>()),
        );
      },
    );
  });

  group('checkOut', () {
    test('should call checkout on datasource with mapped models', () async {
      final tCartItems = [expectShoppingCartEntity];

      when(
        () => mockDatasource.checkOut(body: any(named: 'body')),
      ).thenAnswer((_) async => Future.value());

      // Act
      await repository.checkOut(body: tCartItems);

      // Assert
      verify(() => mockDatasource.checkOut(body: any(named: 'body'))).called(1);
    });
  });
}
