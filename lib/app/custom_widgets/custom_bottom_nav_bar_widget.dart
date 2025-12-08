import 'package:flutter/material.dart';
import 'package:uni_tribe/app/config/app_colors.dart';

Widget buildBottomNavBar({
  required int currentIndex,
  required Function(int) onTap,
}) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: const Color(0xFF1C1F26),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _buildNavItem(
            icon: Icons.map_rounded,
            label: 'Map',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _buildNavItem(
            icon: Icons.people_rounded,
            label: 'Directory',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _buildNavItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    ),
  );
}

Widget _buildNavItem({
  required IconData icon,
  required String label,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      AppColors.gradientStart.withOpacity(0.3),
                      AppColors.gradientEnd.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? AppColors.gradientStart : Colors.grey[500],
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColors.gradientStart : Colors.grey[500],
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}