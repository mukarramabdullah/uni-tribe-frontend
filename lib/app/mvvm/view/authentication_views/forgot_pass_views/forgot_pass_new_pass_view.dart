import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Import your custom widgets
import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_navigation_dashes_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/config/app_colors.dart';
import 'package:uni_tribe/app/config/app_routes.dart';
import 'package:uni_tribe/app/config/app_assets.dart';

class ForgotPasswordNewPassView extends StatefulWidget {
  const ForgotPasswordNewPassView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordNewPassView> createState() =>
      _ForgotPasswordNewPassViewState();
}

class _ForgotPasswordNewPassViewState extends State<ForgotPasswordNewPassView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _isNewPasswordFilled = false;
  bool _isConfirmPasswordFilled = false;

  bool _isNewPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  bool _isLoading = false;

  late String email;
  late String code;

  @override
  void initState() {
    super.initState();

    // Get email and code from arguments
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] ?? '';
    code = args['code'] ?? '';

    print('🟢 Reset Password Screen - Email: $email, Code: $code');

    _newPasswordController.addListener(_updateNewPasswordState);
    _confirmPasswordController.addListener(_updateConfirmPasswordState);

    _newPasswordFocus.addListener(_updateNewPasswordFocusState);
    _confirmPasswordFocus.addListener(_updateConfirmPasswordFocusState);
  }

  void _updateNewPasswordState() {
    setState(() {
      _isNewPasswordFilled = _newPasswordController.text.isNotEmpty;
    });
  }

  void _updateConfirmPasswordState() {
    setState(() {
      _isConfirmPasswordFilled = _confirmPasswordController.text.isNotEmpty;
    });
  }

  void _updateNewPasswordFocusState() {
    setState(() {
      _isNewPasswordFocused = _newPasswordFocus.hasFocus;
    });
  }

  void _updateConfirmPasswordFocusState() {
    setState(() {
      _isConfirmPasswordFocused = _confirmPasswordFocus.hasFocus;
    });
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

  bool _validatePasswords() {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty) {
      _showSnackBar('Please enter a new password', isError: true);
      return false;
    }

    if (newPassword.length < 8) {
      _showSnackBar('Password must be at least 8 characters', isError: true);
      return false;
    }

    if (confirmPassword.isEmpty) {
      _showSnackBar('Please confirm your password', isError: true);
      return false;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar('Passwords do not match', isError: true);
      return false;
    }

    return true;
  }

  Future<void> _handleResetPassword() async {
    if (!_validatePasswords()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement your password reset API call here
      // Example:
      // final response = await yourApiService.resetPassword(
      //   email: email,
      //   code: code,
      //   newPassword: _newPasswordController.text,
      // );

      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      _showSnackBar('Password reset successful!');

      // Navigate to login screen after a short delay
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Failed to reset password. Please try again.',
          isError: true);
      print('Error resetting password: $e');
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBackgroundWidget(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Back Button
                      GestureDetector(
                        onTap: () {
                          if (Get.currentRoute != '/') {
                            Get.back();
                          }
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Title
                      const Text(
                        'Reset\nPassword',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Enter your new password',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.grey300,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // New Password Input
                      _buildInputField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocus,
                        hintText: 'New Password',
                        icon: (_isNewPasswordFilled || _isNewPasswordFocused)
                            ? AppAssets.lockBlackIcon
                            : AppAssets.lockIcon,
                        obscureText: !_isNewPasswordVisible,
                        isFocused: _isNewPasswordFocused,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isNewPasswordVisible = !_isNewPasswordVisible;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              _isNewPasswordVisible
                                  ? AppAssets.eye
                                  : AppAssets.eyeffBlack,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Confirm Password Input
                      _buildInputField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        hintText: 'Confirm Password',
                        icon: (_isConfirmPasswordFilled ||
                                _isConfirmPasswordFocused)
                            ? AppAssets.lockBlackIcon
                            : AppAssets.lockIcon,
                        obscureText: !_isConfirmPasswordVisible,
                        isFocused: _isConfirmPasswordFocused,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              _isConfirmPasswordVisible
                                  ? AppAssets.eye
                                  : AppAssets.eyeffBlack,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Reset Button
                      CustomButton(
                        text: 'Reset Password',
                        onPressed: _handleResetPassword,
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
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
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: CustomNavigationDashes(currentIndex: 2, totalDashes: 3),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required String icon,
    required bool isFocused,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFocused ? AppColors.primary : const Color(0xFFE8E8E8),
          width: isFocused ? 2 : 1,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(icon, width: 20, height: 20),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
