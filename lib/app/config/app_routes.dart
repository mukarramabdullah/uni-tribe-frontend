import 'package:uni_tribe/app/mvvm/view/authentication_views/forgot_pass_views/forgot_password_view.dart';
import 'package:uni_tribe/app/mvvm/view/authentication_views/forgot_pass_views/forgot_password_otp_view.dart';
import 'package:uni_tribe/app/mvvm/view/home_view/home_view.dart';
import 'package:uni_tribe/app/mvvm/view/main_scaffold/main_scaffold.dart';
import 'package:uni_tribe/app/mvvm/view/academic_views/academic_view.dart';
import 'package:uni_tribe/app/mvvm/view/authentication_views/login_view/login_screen.dart';
import 'package:uni_tribe/app/mvvm/view/landing_views/landing_screen.dart';
import 'package:uni_tribe/app/mvvm/view/event_views/event.dart';
import 'package:uni_tribe/app/mvvm/view/lostNfound_view/lostNfound.dart';
import 'package:uni_tribe/app/mvvm/view/profile_setup_views/profile_setup1.dart';
import 'package:uni_tribe/app/mvvm/view/profile_setup_views/profile_setup2.dart';
import 'package:uni_tribe/app/mvvm/view/settings_views/settings_view.dart';
import 'package:uni_tribe/app/mvvm/view/settings_views/create_a_group_view/create_a_group.dart';
import 'package:uni_tribe/app/mvvm/view/settings_views/edit_profile_view/edit_profile.dart';
import 'package:uni_tribe/app/mvvm/view/chats_views/chats_view.dart';
import 'package:uni_tribe/app/mvvm/model/chat_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const landing = '/';
  static const loginScreen = '/loginScreen';
  static const forgotPasswordView = '/forgotPasswordView';
  static const forgotPasswordOtpView = '/forgotPasswordOtpView';
  static const forgotPasswordNewPassView = '/forgotPasswordNewPassView';
  static const registerScreen = '/registerScreen';
  static const homeScreen = '/homeScreen';
  static const academicView = '/academicView';
  static const eventsScreen = '/eventsScreen';
  static const lostNfoundScreen = '/lostNfoundScreen';
  static const profileSetup1 = '/profileSetup1';
  static const profileSetup2 = '/profileSetup2';
  static const settingsView = '/settingsView';
  static const createAGroupView = '/createAGroupView';
  static const editProfileView = '/editProfileView';
  static const chatView = '/chatView';
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.landing,
      page: () => LandingScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => SignInScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordView,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordOtpView,
      page: () => const ForgotPasswordOtpView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const MainScaffold(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.academicView,
      page: () => const AcademicResourcesView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.eventsScreen,
      page: () => const EventsScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.lostNfoundScreen,
      page: () => const LostFoundScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.profileSetup1,
      page: () => const ProfileCompletionScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.profileSetup2,
      page: () => const AddProfilePhotoScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.settingsView,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.createAGroupView,
      page: () => const CreateGroupScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.editProfileView,
      page: () => const EditProfileScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.chatView,
      page: () => ChatScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
    ),
  ];
}
