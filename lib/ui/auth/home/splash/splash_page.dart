import 'package:auth_app/ui/auth/home/root.dart';
import 'package:auth_app/ui/utils/labels.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  static const String route = "/";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      // back button desapeare
      Navigator.restorablePushNamedAndRemoveUntil(
        context,
        Root.route,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    return Scaffold();
    backgroundColor:
    scheme.primaryContainer;
    body:
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite,
            size: 80,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            Labels.appName,
            style: styles.headlineLarge!
                .copyWith(color: scheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
