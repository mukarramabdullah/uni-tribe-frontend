import 'package:flutter/material.dart';
import 'package:uni_tribe/app/config/app_assets.dart';
import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';

class CongratsPopup extends StatelessWidget {
  const CongratsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Green circle with checkmark
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4ADE80),
                    Color(0xFF22C55E),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF22C55E).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                // child: Image.asset(
                //   AppAssets.greenTick,
                //   width: 40,
                //   height: 40,
                //   color: Colors.white,
                // ),
                // Or use Icon if you don't have the asset yet:
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            const Text(
              'Congrats!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 12),

            // Description
            const Text(
              'Group created successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 24),

            // Continue button using CustomButton
            CustomButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage in your app:
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  void _showCongratsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const CongratsPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Congrats Popup Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showCongratsDialog(context),
          child: const Text('Show Congrats Popup'),
        ),
      ),
    );
  }
}
