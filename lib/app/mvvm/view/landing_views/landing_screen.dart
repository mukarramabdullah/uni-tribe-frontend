import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_tribe/app/config/app_assets.dart';
import '../authentication_views/login_view/login_screen.dart';

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
                  width: 220,
                  height: 220,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 40),

                /// ---------- GET STARTED BUTTON ----------
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
