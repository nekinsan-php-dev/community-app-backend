import 'package:flutter/material.dart';
import 'dart:async';
import '../models/otp_state.dart';

class OtpController extends ChangeNotifier {
  OtpState _state = const OtpState();
  Timer? _timer;

  // OTP input controllers and focus nodes
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  // Getters
  OtpState get state => _state;
  List<TextEditingController> get otpControllers => _otpControllers;
  List<FocusNode> get focusNodes => _focusNodes;

  // Check if OTP is complete (all 6 digits entered)
  bool get isOtpComplete {
    String otp = _otpControllers.map((controller) => controller.text).join();
    return otp.length == 6;
  }

  // Get the complete OTP string
  String get otp {
    return _otpControllers.map((controller) => controller.text).join();
  }

  // State management methods
  void setLoading(bool loading) {
    _state = _state.copyWith(isLoading: loading);
    notifyListeners();
  }

  void setResending(bool resending) {
    _state = _state.copyWith(isResending: resending);
    notifyListeners();
  }

  void setError(String? error) {
    _state = _state.copyWith(error: error);
    notifyListeners();
  }

  void setVerificationId(String? verificationId) {
    _state = _state.copyWith(verificationId: verificationId);
    notifyListeners();
  }

  // Focus management
  void focusFirstField() {
    _focusNodes[0].requestFocus();
  }

  // Handle OTP input changes
  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    notifyListeners();
  }

  // Handle backspace
  void onBackspace(int index) {
    if (index > 0) {
      _otpControllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
    notifyListeners();
  }

  // Clear OTP fields
  void clearOtp() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
    focusFirstField();
    notifyListeners();
  }

  // Start resend timer
  void startResendTimer() {
    _timer?.cancel();
    _state = _state.copyWith(resendTimer: 30);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.resendTimer > 0) {
        _state = _state.copyWith(resendTimer: _state.resendTimer - 1);
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  // Verify OTP (placeholder - will be replaced with Firebase implementation)
  Future<void> verifyOtp(BuildContext context) async {
    if (!isOtpComplete) return;

    try {
      setLoading(true);
      setError(null);

      // Simulate OTP verification
      await Future.delayed(const Duration(milliseconds: 2000));

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Resend OTP (placeholder - will be replaced with Firebase implementation)
  Future<void> resendOtp(String phoneNumber, BuildContext context) async {
    if (!_state.canResend) return;

    try {
      setResending(true);
      setError(null);

      // Clear current OTP
      clearOtp();

      // Simulate resend API call
      await Future.delayed(const Duration(milliseconds: 1500));

      // Restart timer
      startResendTimer();
    } catch (e) {
      setError(e.toString());
    } finally {
      setResending(false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
