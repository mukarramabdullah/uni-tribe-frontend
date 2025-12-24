import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tribe/app/mvvm/view_model/navigation_controller.dart';
import 'package:uni_tribe/app/mvvm/view/home_view/home_view.dart';
import 'package:uni_tribe/app/mvvm/view/academic_views/academic_view.dart';
import 'package:uni_tribe/app/mvvm/view/event_views/event.dart';
import 'package:uni_tribe/app/mvvm/view/settings_views/settings_view.dart';
import 'package:uni_tribe/app/config/app_colors.dart';
import 'package:uni_tribe/app/custom_widgets/custom_bottom_nav_bar_widget.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the navigation controller
    final NavigationController navController = Get.put(
      NavigationController(),
      permanent: true,
    );

    return WillPopScope(
      onWillPop: () async {
        // If not on first tab, go to first tab
        if (navController.currentIndex.value != 0) {
          navController.changePage(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D26),
        body: Obx(() {
          // Show different screens based on selected tab index
          switch (navController.currentIndex.value) {
            case 0:
              return const HomeView();
            case 1:
              return const EventsScreen();
            case 2:
              return const AcademicResourcesView();
            case 3:
              return const SettingsScreen();
            default:
              return const HomeView();
          }
        }),
        bottomNavigationBar: Obx(
          () => buildBottomNavBar(
            currentIndex: navController.currentIndex.value,
            onTap: (index) {
              print('🟢 Bottom nav tapped: Tab $index');
              navController.changePage(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: AppColors.gradientStart,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
