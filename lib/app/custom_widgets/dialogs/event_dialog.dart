import 'package:flutter/material.dart';

class UploadEventDialog extends StatefulWidget {
  const UploadEventDialog({Key? key}) : super(key: key);

  @override
  State<UploadEventDialog> createState() => _UploadEventDialogState();
}

class _UploadEventDialogState extends State<UploadEventDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  
  List<String> selectedImages = [];

  @override
  void dispose() {
    titleController.dispose();
    timeController.dispose();
    dateController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Upload Event',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Enter the details for the new event.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: titleController,
                      hintText: 'e.g., Annual Homecoming Bonfire',
                    ),
                    const SizedBox(height: 16),

                    // Time and Date Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller: timeController,
                                hintText: '--:-- --',
                                suffixIcon: Icons.access_time,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller: dateController,
                                hintText: 'mm/dd/yyyy',
                                suffixIcon: Icons.calendar_today,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Location Field
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: locationController,
                      hintText: 'e.g., Alumni Green',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Upload File Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _pickImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D5F3F),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Upload File',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F5F5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: Colors.grey[400],
                size: 20,
              )
            : null,
      ),
    );
  }

  void _pickImages() async {
    // TODO: Implement image picker using image_picker package
    // This should only accept images (jpg, png, etc.)
    // Example:
    // final ImagePicker picker = ImagePicker();
    // final List<XFile>? images = await picker.pickMultiImage();
    
    // Validate inputs first
    if (titleController.text.isEmpty) {
      _showSnackBar('Please enter a title');
      return;
    }
    
    if (timeController.text.isEmpty) {
      _showSnackBar('Please enter a time');
      return;
    }
    
    if (dateController.text.isEmpty) {
      _showSnackBar('Please enter a date');
      return;
    }
    
    if (locationController.text.isEmpty) {
      _showSnackBar('Please enter a location');
      return;
    }

    // Simulating image selection for now
    setState(() {
      selectedImages = ['image1.jpg', 'image2.jpg'];
    });

    // TODO: Upload images to backend
    _showSnackBar('Event uploaded successfully!');
    
    // Close dialog after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF2D5F3F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}