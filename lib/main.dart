import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:localization/localization.dart';
import 'package:preferences/preferences.dart';
import 'package:riverpod_scalable_app/core/utils/context_locale_extension.dart';
import 'package:riverpod_scalable_app/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router/app_router.dart';
import 'core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  final sharedPreferences = await SharedPreferences.getInstance();
  final prefs = Preferences(sharedPreferences);

  runApp(ProviderScope(overrides: [
    preferencesProvider.overrideWithValue(prefs),
  ], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver  {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint("App is inactive.");
        break;
      case AppLifecycleState.paused:
        debugPrint("App is paused.");
        break;
      case AppLifecycleState.resumed:
        debugPrint("App is resumed.");
        break;
      case AppLifecycleState.detached:
        debugPrint("App is detached.");
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeNotifier = ref.read(localeProvider.notifier);
    final themeNotifier = ref.read(themeProvider.notifier);
    ref.watch(localeProvider);
    ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Firebase Scalable App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig:ref.watch(goRouterProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          Future.microtask(() async {
            themeNotifier.loadSavedValue();
          });
          if (!localeNotifier.isLocaleChanged) {
            Future.microtask(() async {
              if (context.mounted) {
                localeNotifier.setLocale(context.locale);
              }
            });
          }
          return child!;
        });
  }
}
