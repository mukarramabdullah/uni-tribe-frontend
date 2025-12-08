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
        /// Lottie animated background with opacity
        Positioned.fill(
          child: Opacity(
            opacity: 0.5,
            child: Lottie.asset(
              'assets/animations/Bubbles.json',
              fit: BoxFit.cover,
            ),
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
