import 'package:auth_app/main.dart';
import 'package:auth_app/ui/auth/home/root.dart';
import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/auth/home/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './app_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), actions: [
        IconButton(
          onPressed: () async {
            await ref.read(authViewModelProvider).logout();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, Root.route);
          },
          icon: Icon(Icons.logout_outlined),
        ),
      ]),
      drawer: MainDrawer(),
    );
  }
}
