import 'package:flutter/material.dart';
import '../models/auth_state.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  AuthState _state = const AuthState();
  final AuthService _authService = AuthService();

  AuthState get state => _state;

  void toggleAuthMode() {
    _state = _state.copyWith(isLogin: !_state.isLogin);
    notifyListeners();
  }

  void setLoading(bool loading) {
    _state = _state.copyWith(isLoading: loading);
    notifyListeners();
  }

  void setError(String? error) {
    _state = _state.copyWith(error: error);
    notifyListeners();
  }

  Future<void> sendOTP(String phoneNumber, BuildContext context) async {
    try {
      setLoading(true);
      setError(null);

      // Store phone number
      _state = _state.copyWith(phoneNumber: phoneNumber);

      await _authService.sendOTP(phoneNumber);

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/otp_verification');
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
