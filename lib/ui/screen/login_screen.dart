import 'package:flutter/material.dart';
import 'package:libellus/ui/widget/route/settings/settings_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SettingsWidget(
          isLoginScreen: true,
        ),
      ),
    ));
  }
}
