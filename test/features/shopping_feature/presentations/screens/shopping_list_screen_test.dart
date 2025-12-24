// ignore_for_file: invalid_use_of_visible_for_overriding_member

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/features/shopping_feature/configs/content/app_localizations.dart';
import 'package:shopping_app/features/shopping_feature/configs/keys/widget_key_config.dart';
import 'package:shopping_app/features/shopping_feature/domain/entities/shopping_get_items_entity.dart';
import 'package:shopping_app/features/shopping_feature/domain/entities/shopping_get_recommended_items_entity.dart';
import 'package:shopping_app/features/shopping_feature/presentation/providers/shopping_providers.dart';
import 'package:shopping_app/features/shopping_feature/presentation/screens/shopping_list_screen.dart';
import 'package:shopping_app/features/shopping_feature/presentation/viewmodels/shopping_get_items_view_model.dart';
import 'package:shopping_app/features/shopping_feature/presentation/viewmodels/shopping_get_recommended_items_view_model.dart';
import 'package:shopping_app/features/shopping_feature/presentation/widgets/shopping_item_card.dart';

import '../../domain/entities/shopping_get_items_entity_test.dart';

class MockShoppingGetItemsNotifier extends AsyncNotifier<ShoppingItemsResponseEntity>
    with Mock
    implements ShoppingGetItemsViewModel {}

class MockShoppingRecommendedNotifier extends AsyncNotifier<ShoppingRecommendedItemsResponseEntity>
    with Mock
    implements ShoppingGetRecommendedItemsViewModel {}

void main() {
  late MockShoppingGetItemsNotifier mockItemsNotifier;
  late MockShoppingRecommendedNotifier mockRecNotifier;
  final mockData = expectShoppingItemsResponseEntity;

  setUp(() {
    mockItemsNotifier = MockShoppingGetItemsNotifier();
    mockRecNotifier = MockShoppingRecommendedNotifier();
  });

  Widget createTestWidget({required List<Override> overrides}) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: const [Locale('en'), Locale('th')],
        home: const ShoppingListScreen(),
      ),
    );
  }

  group('ShoppingListScreen Tests', () {
    testWidgets('Should show loading indicators initially', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          overrides: [
            shoppingGetItemsProvider.overrideWith(() => mockItemsNotifier),
            shoppingGetRecommendedItemsProvider.overrideWith(() => mockRecNotifier),
          ],
        ),
      );

      expect(find.byKey(const Key(somethingWentWrongWidget)), findsNWidgets(2));
    });

    testWidgets('Should render lists when data is loaded', (tester) async {
      // Setup mock returns
      when(() => mockItemsNotifier.build()).thenAnswer((_) async => mockData);

      await tester.pumpWidget(
        createTestWidget(
          overrides: [
            shoppingGetItemsProvider.overrideWith(() => mockItemsNotifier),
            shoppingGetRecommendedItemsProvider.overrideWith(() => mockRecNotifier),
          ],
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(ShoppingItemCard), findsWidgets);
    });
  });
}
