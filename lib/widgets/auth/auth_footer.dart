import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onToggle;

  const AuthFooter({super.key, required this.isLogin, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Terms & Privacy (only show for signup)
        if (!isLogin) ...[
          const Text(
            'By continuing, you agree to our Terms of Service and Privacy Policy',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMedium,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
        ],

        // Switch between Login/Signup
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? "Don't have an account? " : "Already have an account? ",
              style: const TextStyle(fontSize: 16, color: AppColors.textMedium),
            ),
            GestureDetector(
              onTap: onToggle,
              child: Text(
                isLogin ? 'Sign Up' : 'Sign In',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
