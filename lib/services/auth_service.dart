class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<void> sendOTP(String phoneNumber) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Here you would make actual API call
    // Example:
    // final response = await http.post(
    //   Uri.parse('$baseUrl/send-otp'),
    //   body: {'phone': phoneNumber},
    // );
    //
    // if (response.statusCode != 200) {
    //   throw Exception('Failed to send OTP');
    // }
  }

  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Here you would make actual API call for OTP verification
    // For demo purposes, return true
    return true;
  }

  Future<void> logout() async {
    // Handle logout logic
    // Clear tokens, user data, etc.
  }
}
