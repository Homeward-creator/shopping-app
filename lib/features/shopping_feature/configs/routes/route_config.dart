import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/shopping_cart_screen.dart';
import '../../presentation/screens/shopping_list_screen.dart';

const String shoppingListRouteName = 'list';
const String shoppingCartRouteName = 'cart';

const String shoppingRoute = '/shopping';
const String shoppingListRoute = '/list';
const String shoppingCartRoute = '/cart';

final shoppingGoRouter = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '$shoppingRoute$shoppingListRoute',
    routes: <RouteBase>[
      GoRoute(
        path: '$shoppingRoute$shoppingListRoute',
        name: shoppingListRouteName,
        builder: (context, state) => ShoppingListScreen(),
      ),
      GoRoute(
        path: '$shoppingRoute$shoppingCartRoute',
        name: shoppingCartRouteName,
        builder: (context, state) => ShoppingCartScreen(),
      ),
    ],
  );
});
