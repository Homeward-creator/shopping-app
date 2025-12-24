import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/providers/navigation_bar_provider.dart';
import '../../../../configs/theme_config/theme_config.dart';
import '../../configs/content/app_localizations.dart';
import '../../configs/keys/widget_key_config.dart';
import '../../configs/routes/route_config.dart';
import '../../domain/entities/shopping_get_items_entity.dart';
import '../providers/shopping_providers.dart';
import '../widgets/shopping_item_card.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(shoppingGetItemsProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _somethingWentWrongWidget({
    required BuildContext context,
    required WidgetRef ref,
    required bool isFromLatest,
  }) {
    final shoppingGetItem = ref.watch(shoppingGetItemsProvider);
    return Row(
      key: const Key(somethingWentWrongWidget),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Icon(Icons.cancel_outlined, size: 65, color: PrimaryTheme.color.redError),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                AppLocalizations.of(context).shoppingListSomethingWentWrongLabel,
                style: TextStyle(fontSize: 22),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                isFromLatest
                    ? ref
                          .read(shoppingGetItemsProvider.notifier)
                          .getProductItems(
                            body: ShoppingGetItemsBodyEntity(
                              cursor: shoppingGetItem.value?.cursor,
                              limit: 20,
                            ),
                          )
                    : ref
                          .read(shoppingGetRecommendedItemsProvider.notifier)
                          .getRecommendedProductItems();
              },
              child: Text(AppLocalizations.of(context).shoppingListRefreshLabel),
            ),
          ],
        ),
      ],
    );
  }

  Widget _recommendedProduct({required BuildContext context, required WidgetRef ref}) {
    final getRecommendedProductItemProvider = ref.watch(shoppingGetRecommendedItemsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Text(
            AppLocalizations.of(context).shoppingListRecommendedProductLabel,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
          ),
        ),
        getRecommendedProductItemProvider.when(
          data: (data) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.items.length > 4 ? 4 : data.items.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ShoppingItemCard(
                  itemId: data.items[index].itemId,
                  itemName: data.items[index].itemName,
                  itemPrice: data.items[index].itemPrice,
                ),
              );
            },
          ),
          error: (error, stackTrace) =>
              _somethingWentWrongWidget(context: context, ref: ref, isFromLatest: true),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  Widget _latestProduct({required BuildContext context, required WidgetRef ref}) {
    final getProductItemProvider = ref.watch(shoppingGetItemsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Text(
            AppLocalizations.of(context).shoppingListLatestProductLabel,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
          ),
        ),
        getProductItemProvider.when(
          data: (data) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.items.length + (data.cursor != null ? 1 : 0),
            itemBuilder: (_, index) {
              if (index < data.items.length) {
                final item = data.items[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ShoppingItemCard(
                    itemId: item.itemId,
                    itemName: item.itemName,
                    itemPrice: item.itemPrice,
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          error: (error, stackTrace) =>
              _somethingWentWrongWidget(context: context, ref: ref, isFromLatest: true),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final navigationProvider = ref.watch(navigationBarProvider);

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _recommendedProduct(context: context, ref: ref),
                  _latestProduct(context: context, ref: ref),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationProvider,
            onDestinationSelected: (value) {
              if (value == 1) {
                context.push('$shoppingRoute$shoppingCartRoute');
              }
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.star),
                label: AppLocalizations.of(context).shoppingListShoppingNavBarLabel,
              ),
              NavigationDestination(
                icon: Icon(Icons.star),
                label: AppLocalizations.of(context).shoppingListCartNavBarLabel,
              ),
            ],
          ),
        );
      },
    );
  }
}
