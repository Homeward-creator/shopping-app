import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationBarProvider = NotifierProvider<NavigationBarProvider, int>(() {
  return NavigationBarProvider();
});

class NavigationBarProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  // NOTE?: In case there are more page
  void onSelected({required int selectedIndex}) {
    state = selectedIndex;
  }
}
