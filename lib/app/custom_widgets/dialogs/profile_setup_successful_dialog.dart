import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';
import 'package:uni_tribe/app/config/app_routes.dart';
import 'package:get/get.dart';

class RegistrationSuccessDialog extends StatelessWidget {
  final Map<String, dynamic>? arguments;

  const RegistrationSuccessDialog({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/green_tick_registeration.json',
              // width: 100,
              // height: 100,
              repeat: false,
            ),
            const SizedBox(height: 24),
            const Text(
              'Profile Successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Thank you for signing up. We\'re excited to have you with us. You can now log in and start exploring all the features we have to offer.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Confirm',
              onPressed: () {
                if (arguments != null) {
                  Get.offAllNamed(
                    AppRoutes.homeScreen,
                    arguments: arguments,
                  );
                } else {
                  Get.offAllNamed(
                    AppRoutes.homeScreen,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show the dialog
void showRegistrationSuccessDialog(BuildContext context,
    {Map<String, dynamic>? arguments}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return RegistrationSuccessDialog(arguments: arguments);
    },
  );
}
