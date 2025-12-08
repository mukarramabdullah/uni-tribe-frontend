import 'package:flutter/material.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/custom_widgets/dialogs/academic_resources_dialog.dart';

class AcademicResourcesView extends StatefulWidget {
  const AcademicResourcesView({Key? key}) : super(key: key);

  @override
  State<AcademicResourcesView> createState() => _AcademicResourcesViewState();
}

class _AcademicResourcesViewState extends State<AcademicResourcesView> {
  // Tab selection
  bool isPastPapersSelected = true;

  // TODO: Fetch papers from backend API
  List<Map<String, dynamic>> papers = [
    {
      'title': 'CHEM101 Midterm',
      'semester': 'Fall 2023',
      'professor': 'Prof. Smith',
      'uploadedBy': 'JaneDoe',
      'fileType': 'pdf',
    },
    {
      'title': 'CS205 Final Exam 2022',
      'semester': 'Spring 2022',
      'professor': 'Prof. Alan',
      'uploadedBy': 'JohnSmith',
      'fileType': 'doc',
    },
    {
      'title': 'PHYS110 Exam Paper',
      'semester': 'Fall 2021',
      'professor': 'Prof. Curie',
      'uploadedBy': 'Admin',
      'fileType': 'pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Search Bar
                        _buildSearchBar(),
                        const SizedBox(height: 24),

                        // Upload Card
                        _buildUploadCard(),
                        const SizedBox(height: 24),

                        // Tabs
                        _buildTabs(),
                        const SizedBox(height: 24),

                        // Papers List
                        _buildPapersList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF1A1A1A),
                size: 24,
              ),
            ),
          ),

          // Title
          const Text(
            'Academic Resources',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),

          // Placeholder for alignment
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search papers, assignments...',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFD4E9DD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2D5F3F),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF2D5F3F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.upload_file_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Upload a File',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Contribute your assignments or past papers.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Button
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const UploadFileDialog(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF2D5F3F),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2D5F3F).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Choose File',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isPastPapersSelected = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isPastPapersSelected
                    ? const Color(0xFF2D5F3F)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (isPastPapersSelected)
                    BoxShadow(
                      color: const Color(0xFF2D5F3F).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Text(
                'Past Papers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isPastPapersSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isPastPapersSelected = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: !isPastPapersSelected
                    ? const Color(0xFF2D5F3F)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isPastPapersSelected)
                    BoxShadow(
                      color: const Color(0xFF2D5F3F).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Text(
                'Assignments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      !isPastPapersSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPapersList() {
    return Column(
      children: papers.map((paper) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildPaperItem(paper),
        );
      }).toList(),
    );
  }

  Widget _buildPaperItem(Map<String, dynamic> paper) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // File Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFD4E9DD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              paper['fileType'] == 'pdf'
                  ? Icons.picture_as_pdf_rounded
                  : Icons.description_rounded,
              color: const Color(0xFF2D5F3F),
              size: 30,
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paper['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${paper['semester']} | ${paper['professor']}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Uploaded by ${paper['uploadedBy']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Download Button
          GestureDetector(
            onTap: () {
              // TODO: Download file
              print('Download: ${paper['title']}');
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFD4E9DD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.download_rounded,
                color: Color(0xFF2D5F3F),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
