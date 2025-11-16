import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text; //  Required customizable text
  final double? width; // Optional custom width
  final double? height; // Optional custom height
  final double? fontSize; // Optional custom font size
  final Color? backgroundColor; // Optional custom background color
  final Color? pressedBackgroundColor; // Optional pressed background color
  final Color? textColor; // Optional custom text color
  final Color? pressedTextColor; // Optional pressed text color
  final Color? borderColor; // Optional custom border color

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 370,
    this.height = 56,
    this.fontSize = 16,
    this.backgroundColor = const Color(0xFF0A400C),
    this.pressedBackgroundColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFFFFFFFF),
    this.pressedTextColor = const Color(0xFF0A400C),
    this.borderColor = const Color(0xFF0A400C),
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomBlackButtonState();
}

class _CustomBlackButtonState extends State<CustomButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: isPressed
              ? widget.pressedBackgroundColor
              : widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.borderColor ?? const Color(0xFF0A400C),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            widget.text, // 🎯 Uses custom text
            style: TextStyle(
              color: isPressed ? widget.pressedTextColor : widget.textColor,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
