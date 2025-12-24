// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shopping App';

  @override
  String get shoppingCartAppBarLabel => 'Cart';

  @override
  String get shoppingCartEmptyCartLabel => 'Empty Cart';

  @override
  String get shoppingCartGoToShoppingLabel => 'Go to shopping';

  @override
  String get shoppingCartSubtotalLabel => 'Subtotal';

  @override
  String get shoppingCartPromotionDiscountLabel => 'Promotion discount';

  @override
  String get shoppingCartCheckoutLabel => 'Checkout';

  @override
  String get shoppingCartCheckOutErrorLabel => 'Something went wrong';

  @override
  String get shoppingListSomethingWentWrongLabel => 'Something went wrong';

  @override
  String get shoppingListRefreshLabel => 'Refresh';

  @override
  String get shoppingListRecommendedProductLabel => 'Recommended Product';

  @override
  String get shoppingListLatestProductLabel => 'Latest Product';

  @override
  String get shoppingListShoppingNavBarLabel => 'Shopping';

  @override
  String get shoppingListCartNavBarLabel => 'Cart';
}
