import 'package:auth_app/ui/auth/home/router.dart';
import 'package:auth_app/ui/auth/home/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        buttonTheme: ButtonThemeData(
            shape: StadiumBorder(), textTheme: ButtonTextTheme.primary),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: SplashPage.route,
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
