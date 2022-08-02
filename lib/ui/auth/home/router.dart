import 'package:auth_app/ui/auth/home/register_page.dart';
import 'package:auth_app/ui/auth/home/root.dart';
import 'package:auth_app/ui/auth/home/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late final Widget selectedPage;

    switch (settings.name) {
      case SplashPage.route:
        selectedPage = SplashPage();
        break;
      case RegisterPage.route:
        selectedPage = RegisterPage();
        break;
      default:
        selectedPage = Root();
        break;
    }
    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}
