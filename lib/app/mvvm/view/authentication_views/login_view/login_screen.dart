import 'package:flutter/material.dart';
import 'package:uni_tribe/app/config/app_assets.dart';
import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:get/get.dart';
import 'package:uni_tribe/app/config/app_routes.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: customBackgroundWidget(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    AppAssets.uniImage,
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Sign in title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Email field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _isEmailFocused
                            ? Color(0xFF0A400C)
                            : Color.fromARGB(255, 149, 149, 149),
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      controller: _emailController,
                      onTap: () => setState(() => _isEmailFocused = true),
                      onSubmitted: (_) =>
                          setState(() => _isEmailFocused = false),
                      onEditingComplete: () =>
                          setState(() => _isEmailFocused = false),
                      decoration: InputDecoration(
                        hintText: 'Email or User Name',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: _isEmailFocused
                              ? Color(0xFF0A400C)
                              : Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Password field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _isPasswordFocused
                            ? Color(0xFF0A400C)
                            : Color.fromARGB(255, 189, 189, 189),
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      onTap: () => setState(() => _isPasswordFocused = true),
                      onSubmitted: (_) =>
                          setState(() => _isPasswordFocused = false),
                      onEditingComplete: () =>
                          setState(() => _isPasswordFocused = false),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: _isPasswordFocused
                              ? Color(0xFF0A400C)
                              : Colors.grey[400],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isPasswordFocused
                                ? Color(0xFF0A400C)
                                : Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Forget Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.forgotPasswordView);
                      },
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Sign in Button
                  CustomButton(
                    text: 'Sign in',
                    onPressed: () {
                      Get.offNamed(AppRoutes.homeScreen);
                    },
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Google Button
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      AppAssets.googleButton,
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
