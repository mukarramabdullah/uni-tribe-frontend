import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Observable variable for current page index
  var currentIndex = 0.obs;

  // Method to change page
  void changePage(int index) {
    if (index >= 0 && index <= 3) {
      currentIndex.value = index;
    }
  }

  // Method to reset to home tab
  void resetToHome() {
    currentIndex.value = 0;
  }

  // Check if currently on home tab
  bool get isOnHomeTab => currentIndex.value == 0;

  // Get current tab name for debugging
  String get currentTabName {
    switch (currentIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'Map';
      case 2:
        return 'Directory';
      case 3:
        return 'Profile';
      default:
        return 'Unknown';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize on home tab
    currentIndex.value = 0;
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}