class AuthState {
  final bool isLogin;
  final bool isLoading;
  final String? error;
  final String? phoneNumber;

  const AuthState({
    this.isLogin = true,
    this.isLoading = false,
    this.error,
    this.phoneNumber,
  });

  AuthState copyWith({
    bool? isLogin,
    bool? isLoading,
    String? error,
    String? phoneNumber,
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
