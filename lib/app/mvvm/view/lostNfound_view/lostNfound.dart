import 'package:flutter/material.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/custom_widgets/dialogs/lostNfound_dialog.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({Key? key}) : super(key: key);

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> {
  // TODO: Fetch items from backend API
  List<Map<String, dynamic>> items = [
    {
      'title': 'Lost Hydro Flask',
      'description': 'Lost seen near the library',
      'date': 'Oct 26, 2023',
      'status': 'Still Missing',
      'image': 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400',
      'isClaimed': false,
    },
    {
      'title': 'Black Sony Headphones',
      'description': 'Left in lecture hall 3B',
      'date': 'Oct 24, 2023',
      'status': 'Claimed',
      'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      'isClaimed': true,
    },
    {
      'title': 'Set of Keys',
      'description': 'Dropped near the student union',
      'date': 'Oct 22, 2023',
      'status': 'Still Missing',
      'image': null,
      'isClaimed': false,
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
                        // Upload Photo Card
                        _buildUploadPhotoCard(),
                        const SizedBox(height: 20),

                        // Search Bar
                        _buildSearchBar(),
                        const SizedBox(height: 20),

                        // Items List
                        _buildItemsList(),
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
            'Lost & Found',
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

  Widget _buildUploadPhotoCard() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ReportLostFoundDialog(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(28),
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF2D5F3F),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_upload_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            const Text(
              'Upload a Photo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Tap to upload an image of your lost or\nfound item.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
                hintText: 'Search by keywords...',
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

  Widget _buildItemsList() {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildItemCard(item),
        );
      }).toList(),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: item['isClaimed']
                        ? const Color(0xFFD4E9DD)
                        : const Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: item['isClaimed']
                          ? const Color(0xFF2D5F3F)
                          : const Color(0xFFD32F2F),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 6),

                // Description
                Text(
                  item['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),

                // Date
                Text(
                  'Date: ${item['date']}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 16),

                // View Details Button
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to item details
                    print('View details: ${item['title']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4E9DD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D5F3F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Item Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: item['image'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.vpn_key_rounded,
                    size: 40,
                    color: Colors.grey,
                  ),
          ),
        ],
      ),
    );
  }
}