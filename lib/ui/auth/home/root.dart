import 'package:auth_app/ui/auth/home/home_page.dart';
import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login_page.dart';

class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);
  static const String route = "/root";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authViewModelProvider);
    return auth.user != null ? const HomePage() : LoginPage();
  }
}
