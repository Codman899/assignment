import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appsnackbar {
  final BuildContext context;
  Appsnackbar(this.context);
  ThemeData get _theme => Theme.of(context);
  TextTheme get _styles => _theme.textTheme;
  ColorScheme get _scheme => _theme.colorScheme;

  void error(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      // to give user-not found message in shadow at bottom
      SnackBar(
        content: Text(
          "$e",
          style: _styles.bodyLarge!.copyWith(
            color: _scheme.onErrorContainer,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _scheme.errorContainer,
      ),
    );
  }
}
