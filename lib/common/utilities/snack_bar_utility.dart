import 'package:flutter/material.dart';

import '../../configs/theme_config/theme_config.dart';

extension SnackBarUtility on BuildContext {
  void showSnackBarError({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: PrimaryTheme.color.redError,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
