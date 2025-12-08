import 'package:uni_tribe/app/mvvm/view/authentication_views/forgot_pass_views/forgot_password_view.dart';
import 'package:uni_tribe/app/mvvm/view/authentication_views/forgot_pass_views/forgot_password_otp_view.dart';
import 'package:uni_tribe/app/mvvm/view/home_view/home_view.dart';
import 'package:uni_tribe/app/mvvm/view/academic_views/academic_view.dart';
import 'package:uni_tribe/app/mvvm/view/authentication_views/login_view/login_screen.dart';
import 'package:uni_tribe/app/mvvm/view/landing_views/landing_screen.dart';
import 'package:uni_tribe/app/mvvm/view/event_views/event.dart';
import 'package:uni_tribe/app/mvvm/view/lostNfound_view/lostNfound.dart';

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
      page: () => const HomeView(),
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
  ];
}
