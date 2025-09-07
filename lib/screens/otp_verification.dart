import 'package:flutter/material.dart';
import 'dart:async';
import '../../controllers/otp_controller.dart';
import '../../widgets/otp/otp_header.dart';
import '../../widgets/otp/otp_input_fields.dart';
import '../../widgets/otp/otp_verify_button.dart';
import '../../widgets/otp/otp_resend_section.dart';
import '../../widgets/otp/otp_security_notice.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final OtpController _otpController = OtpController();
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(_onOtpStateChanged);
    _otpController.startResendTimer();

    // Auto focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpController.focusFirstField();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get phone number from route arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      _phoneNumber = arguments['phoneNumber'];
    }
  }

  void _onOtpStateChanged() {
    if (mounted) setState(() {});
  }

  void _handleOtpChanged(String value, int index) {
    _otpController.onOtpChanged(value, index);

    // Auto verify when all fields are filled
    if (_otpController.isOtpComplete) {
      _handleVerifyOtp();
    }
  }

  void _handleVerifyOtp() {
    _otpController.verifyOtp(context);
  }

  void _handleResendOtp() {
    if (_phoneNumber != null) {
      _otpController.resendOtp(_phoneNumber!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.grey[700],
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                OtpHeader(phoneNumber: _phoneNumber ?? ''),

                const SizedBox(height: 50),

                OtpInputFields(
                  controllers: _otpController.otpControllers,
                  focusNodes: _otpController.focusNodes,
                  onChanged: _handleOtpChanged,
                  onBackspace: _otpController.onBackspace,
                ),

                const SizedBox(height: 40),

                OtpVerifyButton(
                  isLoading: _otpController.state.isLoading,
                  isOtpComplete: _otpController.isOtpComplete,
                  onPressed: _handleVerifyOtp,
                ),

                const SizedBox(height: 30),

                OtpResendSection(
                  resendTimer: _otpController.state.resendTimer,
                  isResending: _otpController.state.isResending,
                  onResend: _handleResendOtp,
                ),

                const SizedBox(height: 40),

                const OtpSecurityNotice(),

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
    _otpController.removeListener(_onOtpStateChanged);
    _otpController.dispose();
    super.dispose();
  }
}
