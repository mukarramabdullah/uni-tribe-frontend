import 'package:flutter/material.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/custom_widgets/dialogs/event_dialog.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String selectedTab = 'All';

  // TODO: Fetch events from backend API
  List<Map<String, dynamic>> events = [
    {
      'title': 'Fall Semester Career Fair',
      'date': 'October 25',
      'time': '10:00 AM',
      'location': 'Main Auditorium',
      'image': 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      'category': 'ACADEMIC',
    },
    {
      'title': 'Guest Lecture: AI in Science',
      'date': 'October 28',
      'time': '02:00 PM',
      'location': 'Science Hall Rm. 101',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
      'category': 'Events',
    },
    {
      'title': 'Thesis Submission Deadline',
      'date': 'October 31',
      'time': '11:59 PM',
      'location': 'Online Portal',
      'image': 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=800',
      'category': 'Deadlines',
    },
    {
      'title': 'Annual Homecoming Bonfire',
      'date': 'November 03',
      'time': '07:00 PM',
      'location': 'Alumni Green',
      'image': 'https://images.unsplash.com/photo-1520869562399-e772f042f422?w=800',
      'category': 'SOCIAL',
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
                        // Filter Tabs
                        _buildFilterTabs(),
                        const SizedBox(height: 20),

                        // Upload Media Card
                        _buildUploadMediaCard(),
                        const SizedBox(height: 20),

                        // Events List
                        _buildEventsList(),
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
          const Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          // Chat Icon
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(AppRoutes.chat);
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
                Icons.chat_bubble_outline_rounded,
                color: Color(0xFF1A1A1A),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['All', 'Workshops', 'Events', 'Deadlines'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = tab;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2D5F3F) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: const Color(0xFF2D5F3F).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUploadMediaCard() {
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
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF2D5F3F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.upload_file_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Submit Event Media',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            'Have photos or documents from an event?\nUpload them here!',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Button
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const UploadEventDialog(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2D5F3F),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2D5F3F).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Upload File',
                style: TextStyle(
                  fontSize: 15,
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

  Widget _buildEventsList() {
    return Column(
      children: events.map((event) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildEventCard(event),
        );
      }).toList(),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              event['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: const Color(0xFFD4E9DD),
                child: const Icon(
                  Icons.image,
                  size: 60,
                  color: Color(0xFF2D5F3F),
                ),
              ),
            ),
          ),

          // Event Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 12),

                // Date
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 16,
                      color: Color(0xFF2D5F3F),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event['date'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Time
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Color(0xFF2D5F3F),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event['time'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: Color(0xFF2D5F3F),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event['location'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}