// custom_navigation_dashes.dart
import 'package:flutter/material.dart';

class CustomNavigationDashes extends StatelessWidget {
  final int currentIndex;
  final int totalDashes;

  const CustomNavigationDashes({
    Key? key,
    required this.currentIndex,
    this.totalDashes = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalDashes,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentIndex ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == currentIndex ? Colors.black : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
