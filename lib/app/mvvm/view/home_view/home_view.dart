import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:uni_tribe/app/custom_widgets/custom_background_widget.dart';
import 'package:uni_tribe/app/config/app_colors.dart';
import 'package:uni_tribe/app/config/app_routes.dart';
import 'package:uni_tribe/app/mvvm/view_model/navigation_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // User data
  String userName = "Alex";
  String userAvatar = "";

  // Notification banners (scrollable)
  // TODO: Fetch banners from backend API
  List<Map<String, dynamic>> notificationBanners = [
    {
      'title': 'New Library Wing Opens',
      'message': 'Explore the new state-of-the-art facilities.',
      'image':
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800',
    },
    {
      'title': 'Coding Workshop',
      'message': 'Join us this Friday for a hands-on session.',
      'image':
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
    },
  ];

  // Latest updates
  // TODO: Fetch latest updates from backend API
  List<Map<String, dynamic>> latestUpdates = [
    {
      'type': 'news',
      'icon': Icons.article_rounded,
      'title': 'Campus News: New Library...',
      'subtitle': 'Read more about the new facilities...',
      'image':
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=200',
    },
    {
      'type': 'event',
      'icon': Icons.event_rounded,
      'title': 'Upcoming Event: Coding...',
      'subtitle': 'Join us this Friday for a hands-on session.',
      'image':
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=200',
    },
    {
      'type': 'lost_found',
      'icon': Icons.search_rounded,
      'title': 'Lost: Blue Hydro Flask',
      'subtitle': 'Last seen near the student union.',
      'image':
          'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=200',
    },
  ];

  int _currentBannerIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  const SizedBox(height: 24),

                  // Greeting
                  Text(
                    'Good ${_getGreeting()}, $userName',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Scrollable Notification Banners
                  _buildNotificationBanners(),
                  const SizedBox(height: 24),

                  // Quick Access Cards Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAccessCard(
                          icon: Icons.school_rounded,
                          title: 'Academic\nResources',
                          subtitle:
                              'Find course materials, library access & grades.',
                          iconColor: const Color(0xFF2D5F3F),
                          onTap: () {
                            Get.offNamed(AppRoutes.academicView);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildQuickAccessCard(
                          icon: Icons.event_rounded,
                          title: 'Events',
                          subtitle: 'Discover workshops, clubs & campus life.',
                          iconColor: const Color(0xFF2D5F3F),
                          onTap: () {
                            Get.toNamed(AppRoutes.eventsScreen);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Lost & Found Card
                  _buildLostFoundCard(),
                  const SizedBox(height: 32),

                  // Latest Updates Section
                  const Text(
                    'Latest Updates',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Latest Updates List
                  _buildLatestUpdatesList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // User Avatar
        GestureDetector(
          onTap: () {
            Get.find<NavigationController>().changePage(3);
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8D5C4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF6B4423),
              size: 32,
            ),
          ),
        ),

        // Icons Row
        Row(
          children: [
            // Notification Icon
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRoutes.notifications);
              },
              child: Container(
                width: 50,
                height: 50,
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
                  Icons.notifications_outlined,
                  color: Color(0xFF1A1A1A),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Chat Icon
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRoutes.chat);
              },
              child: Container(
                width: 50,
                height: 50,
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
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationBanners() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: notificationBanners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = notificationBanners[index];
              return _buildBannerCard(
                title: banner['title'],
                message: banner['message'],
                imageUrl: banner['image'],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dash indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            notificationBanners.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBannerIndex == index ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentBannerIndex == index
                    ? const Color(0xFF2D5F3F)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerCard({
    required String title,
    required String message,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF6B9080),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Text Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLostFoundCard() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.lostNfoundScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2D5F3F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: Color(0xFF2D5F3F),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lost & Found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Report a lost item or browse found items.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
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

  Widget _buildLatestUpdatesList() {
    return Column(
      children: latestUpdates.map((update) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildUpdateItem(update),
        );
      }).toList(),
    );
  }

  Widget _buildUpdateItem(Map<String, dynamic> update) {
    return GestureDetector(
      onTap: () {
        print('Open update: ${update['title']}');
      },
      child: Container(
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
            // Image Thumbnail
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFE8EEF1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  update['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    update['icon'] as IconData,
                    color: const Color(0xFF6B9080),
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    update['title'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    update['subtitle'],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }
}
