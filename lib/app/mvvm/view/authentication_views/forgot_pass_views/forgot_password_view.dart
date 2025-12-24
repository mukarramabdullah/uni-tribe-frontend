import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Import your custom widgets
import 'package:uni_tribe/app/config/app_assets.dart';
import 'package:uni_tribe/app/config/app_colors.dart';
import 'package:uni_tribe/app/config/app_routes.dart';
import 'package:uni_tribe/app/config/app_utils.dart';

import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_navigation_dashes_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();

  bool _isEmailFilled = false;

  bool _isEmailFocused = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateEmailState);

    _emailFocus.addListener(_updateEmailFocusState);
  }

  void _updateEmailState() {
    setState(() {
      _isEmailFilled = _emailController.text.isNotEmpty;
    });
  }

  void _updateEmailFocusState() {
    setState(() {
      _isEmailFocused = _emailFocus.hasFocus;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();

    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackgroundWidget(
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
                      child: Center(
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
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your email address to receive the\n code into your email',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey300,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Input
                  _buildInputField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    hintText: 'Enter your email',
                    icon: (_isEmailFilled || _isEmailFocused)
                        ? AppAssets.emailBlackIcon
                        : AppAssets.emailIcon,
                    keyboardType: TextInputType.emailAddress,
                    isFocused: _isEmailFocused,
                  ),
                  const SizedBox(height: 16),

                  // Register Button - Using your custom widget
                  // In ForgotPasswordView, update the CustomBlackButton onPressed
                  CustomButton(
                    text: 'Send OTP',
                    onPressed: () async {
                      // Uncomment and use when needed
                      // bool success = await AppUtils.handleForgotPassword(
                      //   email: _emailController.text,
                      // );

                      // if (success) {
                      //   // Navigate to OTP screen
                      //   // Get.toNamed(
                      //   //   AppRoutes.forgotPasswordOtpView,
                      //   //   arguments: {
                      //   //     'email': _emailController.text.trim(),
                      //   //     'from': 'reset',
                      //   //   },
                      //   // );
                      // }
                      Get.toNamed(
                        AppRoutes.forgotPasswordOtpView,
                        arguments: {
                          'email': _emailController.text.trim(),
                          'from': 'reset',
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  // Spacer can't be used inside a scrollable Column; use fixed spacing instead
                  const SizedBox(height: 40),

                  // Navigation Dashes
                  const CustomNavigationDashes(currentIndex: 0, totalDashes: 3),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
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
