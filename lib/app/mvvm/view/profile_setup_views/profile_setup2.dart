import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uni_tribe/app/custom_widgets/custom_button_widget.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/custom_widgets/dialogs/profile_setup_successful_dialog.dart';

class AddProfilePhotoScreen extends StatefulWidget {
  const AddProfilePhotoScreen({Key? key}) : super(key: key);

  @override
  State<AddProfilePhotoScreen> createState() => _AddProfilePhotoScreenState();
}

class _AddProfilePhotoScreenState extends State<AddProfilePhotoScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      _showErrorSnackBar('Failed to open camera');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      _showErrorSnackBar('Failed to open gallery');
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF2D5F3F)),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: Color(0xFF2D5F3F)),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleContinue() {
    // Save image to backend/storage here if needed
    if (_selectedImage != null) {
      print('Continue with image: ${_selectedImage!.path}');
      // TODO: Upload image to your backend/storage
    }

    // Show registration success dialog
    showRegistrationSuccessDialog(context);
  }

  void _handleSkip() {
    // User chose to skip profile photo
    print('Skipped profile photo');

    // Show registration success dialog
    showRegistrationSuccessDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final imageSize = isSmallScreen ? size.width * 0.5 : size.width * 0.55;

    return Scaffold(
      body: customBackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value: 0.5,
                backgroundColor: const Color(0xFF2D5F3F).withOpacity(0.2),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF2D5F3F)),
                minHeight: 4,
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Title
                      Text(
                        'Add a Profile Photo',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 24 : 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),

                      // Profile Image Section
                      Center(
                        child: Stack(
                          children: [
                            // Profile Image Circle
                            Container(
                              width: imageSize,
                              height: imageSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                                image: _selectedImage != null
                                    ? DecorationImage(
                                        image: FileImage(_selectedImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _selectedImage == null
                                  ? Icon(
                                      Icons.person,
                                      size: imageSize * 0.5,
                                      color: Colors.grey.shade400,
                                    )
                                  : null,
                            ),

                            // Delete Button (only show when image is selected)
                            if (_selectedImage != null)
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: GestureDetector(
                                  onTap: _deleteImage,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.pink,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),

                            // Camera Button
                            Positioned(
                              right: 10,
                              top: 10,
                              child: GestureDetector(
                                onTap: _showImageSourceOptions,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2D5F3F),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF2D5F3F)
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),

              // Bottom Buttons
              Padding(
                padding: EdgeInsets.all(size.width * 0.06),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Continue',
                      onPressed: _handleContinue,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _handleSkip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

