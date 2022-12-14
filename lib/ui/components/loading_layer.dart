import 'package:auth_app/ui/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Stack(
      children: [
        child,
        Consumer(
          builder: (context, ref, child) {
            final model = ref.watch(loadingProvider);
            return model.loading
                ? Material(
                    color: scheme.onSurfaceVariant.withOpacity(0.6),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox();
          },
        )
      ],
    );
  }
}
