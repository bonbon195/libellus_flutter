import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libellus/preferences/user_preferences.dart';
import 'package:libellus/ui/screen/home_screen.dart';
import 'package:libellus/ui/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // UserPreferences.setGroupAndFaculty('', '');
    }
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        background: Colors.white,
        surface: Colors.white,
      )),
      onGenerateRoute: (settings) {
        if (UserPreferences.getFaculty() != '') {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        } else {
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}
