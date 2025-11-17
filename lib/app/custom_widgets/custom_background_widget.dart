import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class customBackgroundWidget extends StatelessWidget {
  final Widget child;

  const customBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Lottie animated background
        Positioned.fill(
          child: Lottie.asset(
            'assets/animations/AppBackground.json',
            fit: BoxFit.cover,
          ),
        ),

        /// Foreground content
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
