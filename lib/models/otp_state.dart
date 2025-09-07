class OtpState {
  final bool isLoading;
  final bool isResending;
  final int resendTimer;
  final String? error;
  final String? verificationId;

  const OtpState({
    this.isLoading = false,
    this.isResending = false,
    this.resendTimer = 30,
    this.error,
    this.verificationId,
  });

  OtpState copyWith({
    bool? isLoading,
    bool? isResending,
    int? resendTimer,
    String? error,
    String? verificationId,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      isResending: isResending ?? this.isResending,
      resendTimer: resendTimer ?? this.resendTimer,
      error: error ?? this.error,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  bool get canResend => resendTimer == 0 && !isResending;
}
