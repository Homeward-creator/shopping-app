import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/helpers/format_helper.dart';
import '../../../../common/utilities/snack_bar_utility.dart';
import '../../../../configs/theme_config/theme_config.dart';
import '../../configs/content/app_localizations.dart';
import '../providers/shopping_providers.dart';
import '../widgets/shopping_item_card.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  Widget _emptyCartWidget({required BuildContext context}) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).shoppingCartEmptyCartLabel,
            style: TextStyle(fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () => context.pop(),
              child: Text(AppLocalizations.of(context).shoppingCartEmptyCartLabel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemList({required WidgetRef ref}) {
    final shoppingCart = ref.watch(shoppingCartProvider);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shoppingCart.items.length,
      itemBuilder: (_, index) {
        return Dismissible(
          key: Key('${shoppingCart.items[index].cartItem.itemId}$index'),
          onDismissed: (_) {
            ref
                .read(shoppingCartProvider.notifier)
                .deleteItemFromCart(itemId: shoppingCart.items[index].cartItem.itemId);
          },
          background: Container(
            color: PrimaryTheme.color.redError,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 26),
            child: Icon(Icons.delete, color: PrimaryTheme.color.white),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ShoppingItemCard(
              itemId: shoppingCart.items[index].cartItem.itemId,
              itemName: shoppingCart.items[index].cartItem.itemName,
              itemPrice: shoppingCart.items[index].cartItem.itemPrice,
            ),
          ),
        );
      },
    );
  }

  Widget _checkOutWidget({required BuildContext context, required WidgetRef ref}) {
    final shoppingCartResult = ref.watch(shoppingCartResultAmountProvider);
    final shoppingCartDiscount = ref.watch(cartSavingsProvider);
    final shoppingCartTotal = ref.watch(shoppingCartTotalAmountProvider);

    return Container(
      color: PrimaryTheme.color.primary2,
      height: 168,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).shoppingCartSubtotalLabel),
                    Text(formattedPrice(price: shoppingCartTotal)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).shoppingCartPromotionDiscountLabel),
                    shoppingCartDiscount == 0
                        ? Text('-')
                        : Text(
                            '-${formattedPrice(price: shoppingCartDiscount)}',
                            style: TextStyle(color: PrimaryTheme.color.redError),
                          ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formattedPrice(price: shoppingCartResult), style: TextStyle(fontSize: 32)),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref.read(shoppingCartProvider.notifier).checkout();
                      } catch (e) {
                        if (context.mounted) {
                          context.showSnackBarError(
                            message: AppLocalizations.of(context).shoppingCartCheckOutErrorLabel,
                          );
                        }
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).shoppingCartCheckoutLabel,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shopSuccessWidget({required BuildContext context, required WidgetRef ref}) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Success!', style: TextStyle(fontSize: 28)),
          Text('Thank you for shopping with us!', style: TextStyle(fontSize: 14)),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                ref.read(shoppingCartProvider.notifier).resetCheckoutStatus();
                context.pop();
              },
              child: Text('Shop again'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final shoppingCart = ref.watch(shoppingCartProvider);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).shoppingCartAppBarLabel),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: shoppingCart.items.isEmpty
                ? shoppingCart.isCheckoutSuccess
                      ? _shopSuccessWidget(context: context, ref: ref)
                      : _emptyCartWidget(context: context)
                : SingleChildScrollView(child: _itemList(ref: ref)),
          ),
          bottomSheet: shoppingCart.items.isEmpty
              ? null
              : _checkOutWidget(context: context, ref: ref),
        );
      },
    );
  }
}
