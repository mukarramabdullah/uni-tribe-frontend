import 'package:flutter/material.dart';

class UploadFileDialog extends StatefulWidget {
  const UploadFileDialog({Key? key}) : super(key: key);

  @override
  State<UploadFileDialog> createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  
  String? selectedFileName;
  String? selectedFileSize;
  String? selectedFileType;

  @override
  void dispose() {
    titleController.dispose();
    semesterController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 700),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upload File',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF1A1A1A),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: titleController,
                      hintText: 'e.g., Midterm Exam',
                    ),
                    const SizedBox(height: 20),

                    // Semester Field
                    const Text(
                      'Semester',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: semesterController,
                      hintText: 'e.g., Fall 2023',
                    ),
                    const SizedBox(height: 20),

                    // Subject Field
                    const Text(
                      'Subject',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: subjectController,
                      hintText: 'e.g., CHEM101',
                    ),
                    const SizedBox(height: 24),

                    // File Picker Area
                    _buildFilePicker(),
                  ],
                ),
              ),
            ),

            // Upload Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: _buildUploadButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildFilePicker() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFD4E9DD),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF2D5F3F),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            // File Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFB8D4C5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.attach_file_rounded,
                color: Color(0xFF2D5F3F),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // File Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedFileName ?? 'No file chosen',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  if (selectedFileSize != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      selectedFileSize!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Change Button
            if (selectedFileName != null)
              const Text(
                'Change',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5F3F),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _uploadFile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D5F3F),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 4,
          shadowColor: const Color(0xFF2D5F3F).withOpacity(0.4),
        ),
        child: const Text(
          'Upload File',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _pickFile() {
    // TODO: Implement file picker using file_picker package
    // Example: final result = await FilePicker.platform.pickFiles();
    
    // Simulating file selection for now
    setState(() {
      selectedFileName = 'exam_screenshot.png';
      selectedFileSize = '1.2 MB · PNG';
      selectedFileType = 'PNG';
    });
  }

  void _uploadFile() {
    // TODO: Implement file upload to backend
    
    // Validate inputs
    if (titleController.text.isEmpty) {
      _showSnackBar('Please enter a title');
      return;
    }
    
    if (semesterController.text.isEmpty) {
      _showSnackBar('Please enter a semester');
      return;
    }
    
    if (subjectController.text.isEmpty) {
      _showSnackBar('Please enter a subject');
      return;
    }
    
    if (selectedFileName == null) {
      _showSnackBar('Please select a file');
      return;
    }

    // Show success message and close dialog
    _showSnackBar('File uploaded successfully!');
    
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