import 'package:flutter/material.dart';
import 'package:huplyjoi/app/localization/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(local.appName)),
      body: Center(child: Text(local.welcome)),
    );
  }
}