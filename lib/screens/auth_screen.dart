// screens/auth/auth_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/phone_input_section.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_footer.dart';
import '../../controllers/auth_controller.dart';
import '../../models/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authController.addListener(_onAuthStateChanged);
  }

  void _onAuthStateChanged() {
    if (mounted) setState(() {});
  }

  void _handleSubmit() {
    if (_phoneController.text.length == 10) {
      _authController.sendOTP(_phoneController.text, context);
    }
  }

  void _toggleAuthMode() {
    _authController.toggleAuthMode();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),

                AuthHeader(isLogin: _authController.state.isLogin),

                const SizedBox(height: 50),

                PhoneInputSection(controller: _phoneController),

                const SizedBox(height: 32),

                AuthButton(
                  isLogin: _authController.state.isLogin,
                  isLoading: _authController.state.isLoading,
                  onPressed: _handleSubmit,
                ),

                const SizedBox(height: 24),

                AuthFooter(
                  isLogin: _authController.state.isLogin,
                  onToggle: _toggleAuthMode,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _authController.removeListener(_onAuthStateChanged);
    _authController.dispose();
    super.dispose();
  }
}
