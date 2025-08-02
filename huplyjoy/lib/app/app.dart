import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:huplyjoi/app/router/app_router.dart';
import 'package:huplyjoi/app/theme/app_theme.dart';
import 'package:huplyjoi/app/localization/app_localizations.dart';


class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tourism Gamification App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // سيتم التحكم بها من الإعدادات لاحقًا
      routerConfig: AppRouter.router,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      locale: const Locale('ar'), // يمكن تغييره لاحقًا حسب تفضيل المستخدم
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}