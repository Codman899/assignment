import 'package:auth_app/ui/auth/home/register_page.dart';
import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/components/loading_layer.dart';
import 'package:auth_app/ui/components/snackbar.dart';
import 'package:auth_app/ui/utils/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/root.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final provider = authViewModelProvider;
    final model = ref.read(authViewModelProvider);

    return LoadingLayer(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Icon(
                  Icons.shopping_basket_rounded,
                  size: 70,
                ),
                // Image.asset(
                //   "assets/images/forgot_passwordd.png",
                //   height: 100,
                //   width: 100,
                //   fit: BoxFit.cover,
                // ),
                Spacer(),
                Text(
                  Labels.SignIn,
                  style: styles.headlineLarge,
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  // give initial value otherwise signup button shows even in empty state
                  initialValue: model.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: Labels.email,
                  ),
                  onChanged: (v) => model.email = v,
                  validator: (v) => model.emailValidate(v!),
                ),
                SizedBox(height: 15),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(
                        provider.select((value) => value.obscurePassword));
                    return TextFormField(
                      obscureText: model.obscurePassword,
                      // give initial value otherwise signup button shows even in empty state
                      initialValue: model.Password,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        labelText: Labels.password,
                        suffixIcon: IconButton(
                          onPressed: () {
                            model.obscurePassword = !model.obscurePassword;
                          },
                          // for show password (eye)
                          icon: Icon(model.obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      onChanged: (v) => model.Password = v,
                    );
                  },
                ),
                SizedBox(height: 15),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider);
                    return MaterialButton(
                      color: scheme.primaryContainer,
                      padding: EdgeInsets.all(15),
                      onPressed:
                          model.email.isNotEmpty && model.Password.isNotEmpty
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await model.login();
                                      // ignore: use_build_context_synchronously (for statefull widget only), use_build_context_synchronously
                                      Navigator.pushReplacementNamed(
                                          context, Root.route);
                                      // "e" stands for error
                                    } catch (e) {
                                      // we create snackbar file for below code
                                      Appsnackbar(context).error(e);
                                    }
                                  }
                                }
                              : null,
                      child: Text(Labels.SignIn.toUpperCase()),
                    );
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: Labels.dontHaveAnAccount,
                    style: styles.bodyLarge,
                    children: [
                      TextSpan(
                          text: Labels.SignUp,
                          style: styles.button!.copyWith(fontSize: 20),

                          //to send to register page
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, RegisterPage.route);
                            }),
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
