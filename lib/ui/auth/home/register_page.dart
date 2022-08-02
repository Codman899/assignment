import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/components/loading_layer.dart';
import 'package:auth_app/ui/utils/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/snackbar.dart';
import 'root.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);

  static const String route = "/register";
  @override
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final provider = authViewModelProvider;
    final model = ref.read(provider);

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
                // Icon(
                //   Icons.favorite,
                //   size: 70,
                // ),
                Image.asset(
                  "assets/images/thanks.png",
                  height: 152,
                  width: 75,
                  fit: BoxFit.cover,
                ),
                Spacer(),
                Text(
                  Labels.SignUp,
                  style: styles.headlineLarge,
                ),
                SizedBox(
                  height: 20,
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
                Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.obscurePassword));
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
                }),

                SizedBox(height: 15),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider
                        .select((value) => value.obscureConfirmPassword));
                    return TextFormField(
                      obscureText: model.obscureConfirmPassword,
                      // give initial value otherwise signup button shows even in empty state
                      initialValue: model.confirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        labelText: Labels.confirmpassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            model.obscureConfirmPassword =
                                !model.obscureConfirmPassword;
                          },
                          // for show password (eye)
                          icon: Icon(model.obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      onChanged: (v) => model.confirmPassword = v,
                      validator: (v) =>
                          v != model.Password ? "Mismatch Password" : null,
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider);
                    return MaterialButton(
                      color: scheme.primaryContainer,
                      padding: EdgeInsets.all(15),
                      onPressed: model.email.isNotEmpty &&
                              model.Password.isNotEmpty &&
                              model.confirmPassword.isNotEmpty
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await model.register();
                                  // ignore: use_build_context_synchronously (for statefull widget only)
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
                    text: Labels.alreadyHaveAnAccount,
                    style: styles.bodyLarge,
                    children: [
                      TextSpan(
                          text: Labels.SignIn,
                          style: styles.button!.copyWith(fontSize: 20),
                          //to send to register page
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, Labels.SignUp);
                            }),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
