import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_tribe/app/config/app_assets.dart';
import '../authentication_views/login_view/login_screen.dart';
import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ---------- BACKGROUND LOTTIE ANIMATION ----------
          Positioned.fill(
            child: Lottie.asset(
              'assets/animations/Bubbles.json',
              fit: BoxFit.cover,
            ),
          ),

          /// DARK OVERLAY (optional for readability)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.75),
            ),
          ),

          /// ---------- MAIN CONTENT ----------
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // University logo
                Image.asset(
                  AppAssets.universityofLahoreLogo,
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 40),

                /// ---------- GET STARTED BUTTON ----------
                CustomButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
