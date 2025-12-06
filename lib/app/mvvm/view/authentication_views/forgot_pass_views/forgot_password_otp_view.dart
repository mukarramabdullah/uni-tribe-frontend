import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_navigation_dashes_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/config/app_colors.dart';
import 'package:uni_tribe/app/config/app_routes.dart';

class ForgotPasswordOtpView extends StatefulWidget {
  const ForgotPasswordOtpView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpView> createState() => _ForgotPasswordOtpViewState();
}

class _ForgotPasswordOtpViewState extends State<ForgotPasswordOtpView> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  int _resendTimer = 600; // 10 minutes = 600 seconds
  bool _canResend = false;
  bool _isLoading = false;

  // Get data from arguments
  late String email;
  late String from;
  String? fullName;
  String? password;

  @override
  void initState() {
    super.initState();

    // Extract arguments
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] ?? '';
    from = args['from'] ?? '';
    fullName = args['fullName'];
    password = args['password'];

    // Debug prints
    print('🟢 OTP Screen - Email: $email');
    print('🟢 OTP Screen - From: $from');
    print('🟢 OTP Screen - FullName: $fullName');
    print('🟢 OTP Screen - Password: ${password != null ? "***" : "null"}');

    _startResendTimer();
    for (var controller in _otpControllers) {
      controller.addListener(() {
        setState(() {});
      });
    }
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 8) {
      return '${username.substring(0, username.length > 8 ? 8 : username.length)}******@$domain';
    }

    return '${username.substring(0, 8)}******@$domain';
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _handleVerification() async {
    final String otp =
        _otpControllers.map((controller) => controller.text.trim()).join();

    print('🟢 Verification - OTP: $otp');
    print('🟢 Verification - From: $from');

    final bool isValidOtp = otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp);

    if (!isValidOtp) {
      _showSnackBar('Please enter the 6-digit code', isError: true);
      return;
    }

    if (from == 'register') {
      print('🟢 Starting registration verification...');
      print(
        '🟢 FullName: $fullName, Email: $email, Password: ${password != null ? "exists" : "null"}',
      );

      // Verify email and complete registration
      if (fullName == null || password == null) {
        _showSnackBar('Missing registration data', isError: true);
        return;
      }

      setState(() => _isLoading = true);

      // TODO: Implement your registration verification logic here
      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // For now, just show success and navigate
      _showSnackBar('Registration successful!');
      
      // Navigate to login or home
      Get.offAllNamed(AppRoutes.loginScreen);
      
    } else if (from == 'reset') {
      // Handle password reset flow - pass email and OTP code
      Get.toNamed(
        AppRoutes.forgotPasswordNewPassView,
        arguments: {'email': email, 'code': otp},
      );
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    setState(() => _isLoading = true);

    // TODO: Implement your OTP resend logic here
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    _showSnackBar('OTP resent successfully!');
    setState(() {
      _resendTimer = 600;
      _canResend = false;
    });
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBackgroundWidget(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Verify Email',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We sent a 6 digit code to your email',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _maskEmail(email),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0000F0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // OTP Input Fields - 6 digits
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                            (index) => _buildOtpField(index),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Continue Button
                        CustomButton(
                          text: 'Continue',
                          onPressed: _handleVerification,
                        ),

                        const SizedBox(height: 16),

                        // Resend OTP with timer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't get OTP? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                            ),
                            GestureDetector(
                              onTap: _canResend ? _resendOtp : null,
                              child: Text(
                                _canResend
                                    ? 'Resend OTP'
                                    : 'Resend OTP in ${_formatTime(_resendTimer)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      _canResend ? Colors.black : Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CustomNavigationDashes(currentIndex: 1, totalDashes: 3),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOtpField(int index) {
    bool isFilled = _otpControllers[index].text.isNotEmpty;

    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        gradient: isFilled
            ? LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isFilled ? null : AppColors.grey400,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          onChanged: (value) => _onOtpChanged(value, index),
        ),
      ),
    );
  }
}