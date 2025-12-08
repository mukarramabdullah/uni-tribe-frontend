import 'package:flutter/material.dart';

class ReportLostFoundDialog extends StatefulWidget {
  const ReportLostFoundDialog({Key? key}) : super(key: key);

  @override
  State<ReportLostFoundDialog> createState() => _ReportLostFoundDialogState();
}

class _ReportLostFoundDialogState extends State<ReportLostFoundDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  
  String? selectedImage;

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
              child: const Text(
                'Report Lost/Found Item',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
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
                      hintText: 'e.g., Blue Hydro Flask',
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
                      hintText: 'e.g., Near the library',
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
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4E9DD),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.upload_file_rounded,
                            color: Color(0xFF2D5F3F),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Upload File',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D5F3F),
                            ),
                          ),
                        ],
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
                          borderRadius: BorderRadius.circular(12),
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

  void _pickImage() async {
    // TODO: Implement image picker using image_picker package
    // This should only accept images (jpg, png, etc.)
    // Example:
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
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
      selectedImage = 'item_photo.jpg';
    });

    // TODO: Upload image to backend
    _showSnackBar('Item reported successfully!');
    
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