import 'package:flutter/material.dart';
import 'package:proklinik_staff_portal/localization/app_localizations.dart';
import 'package:proklinik_staff_portal/providers/_px_main.dart';
import 'package:proklinik_staff_portal/providers/px_locale.dart';
import 'package:proklinik_staff_portal/providers/px_theme.dart';
import 'package:proklinik_staff_portal/routes/routes.dart';
import 'package:proklinik_staff_portal/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppProvider());
}

class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return const MyApp();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxTheme>(
      builder: (context, l, t, _) {
        return MaterialApp.router(
          //OPTIONS
          debugShowCheckedModeBanner: false,
          title: 'ProKliniK Staff',
          //THEMES
          theme: AppTheme.theme(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
            ),
          ),
          darkTheme: AppTheme.theme(
            colorScheme: const ColorScheme.dark(
              primary: Colors.green,
            ),
            textTheme: const TextTheme().apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
          ),
          themeMode: t.mode,
          //ROUTER
          routerConfig: AppRouter.router,

          //LOCALIZATION
          locale: l.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
