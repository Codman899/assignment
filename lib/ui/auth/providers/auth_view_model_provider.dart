import 'package:auth_app/ui/providers/loading_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = ChangeNotifierProvider(
  (ref) => AuthViewModel(ref.read),
);

class AuthViewModel extends ChangeNotifier {
  final Reader _reader;
  AuthViewModel(this._reader);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;
  String _email = '';
  String get email => _email;

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _Password = '';

  String get Password => _Password;

  set Password(String Password) {
    _Password = Password;
    notifyListeners();
  }

  String _confirmPassword = '';

  String get confirmPassword => _confirmPassword;

  set confirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool obscureText) {
    _obscurePassword = obscureText;
    notifyListeners();
  }

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  set obscureConfirmPassword(bool obscureConfirmPassword) {
    _obscureConfirmPassword = obscureConfirmPassword;
    notifyListeners();
  }

  String? emailValidate(String value) {
    String format =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return !RegExp(format).hasMatch(value) ? "Enter valid information" : null;
  }

  Loading get _loading => _reader(loadingProvider);

  Future<void> login() async {
    _loading.start();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: Password,
      );
      _loading.end();
    } on FirebaseException catch (e) {
      print(e.code);
      _loading.stop();
      if (e.code == "wrong-password") {
        //give return message
        return Future.error("Wrong password!");
      }
      // if firebase give error that user not found then we print this  message
      else if (e.code == "user-not-found") {
        return Future.error("user not found");
      }
    } catch (e) {
      _loading.stop();
      if (kDebugMode) {
        print(e);
      }
    }
  }

// for register
  Future<void> register() async {
    Future<void> login() async {
      _loading.start();
      try {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: Password,
        );
        _loading.end();
      } on FirebaseException catch (e) {
        _loading.stop();
        //A [FirebaseAuthException] maybe thrown with the many error code
        if (e.code == "weak-password") {
          return Future.error("Enter strong password!");
        }
      } catch (e) {
        _loading.stop();
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
