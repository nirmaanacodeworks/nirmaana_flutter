import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;

  void setEmail(String value) => _email = value;
  void setPassword(String value) => _password = value;

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Attempt login with Email: $_email, Password: $_password');

    _isLoading = false;
    notifyListeners();
  }

  void forgotPassword() => debugPrint('Forgot password clicked for $_email');

  void navigateToSignUp() => debugPrint('Navigate to Sign Up clicked');
}
