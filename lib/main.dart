import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'configs/theme_config/theme_config.dart';
import 'features/shopping_feature/configs/content/app_localizations.dart';
import 'features/shopping_feature/configs/routes/route_config.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final RouterConfig<Object>? goRouter = ref.watch(shoppingGoRouter);

    return MaterialApp.router(
      routerConfig: goRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: PrimaryTheme.color.surface,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimaryTheme.color.primary,
            foregroundColor: PrimaryTheme.color.white,
          ),
        ),
      ),
    );
  }
}
