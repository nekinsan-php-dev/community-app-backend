import 'package:flutter/material.dart';

class OtpVerifyButton extends StatelessWidget {
  final bool isLoading;
  final bool isOtpComplete;
  final VoidCallback onPressed;

  const OtpVerifyButton({
    super.key,
    required this.isLoading,
    required this.isOtpComplete,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: isOtpComplete
            ? const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isOtpComplete ? null : Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        boxShadow: isOtpComplete
            ? [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: (isLoading || !isOtpComplete) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                'Verify & Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isOtpComplete ? Colors.white : Colors.grey[600],
                ),
              ),
      ),
    );
  }
}
