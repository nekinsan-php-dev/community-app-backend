import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const OtpHeader({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // OTP Icon
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.sms_rounded, color: Colors.white, size: 40),
          ),
        ),

        const SizedBox(height: 40),

        // Title
        const Text(
          'Verify Your Number',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        // Description with phone number
        Text(
          'Enter the 6-digit code sent to\n+91 ${_formatPhoneNumber(phoneNumber)}',
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5)}';
    }
    return phoneNumber;
  }
}
