import 'package:uni_tribe/app/mvvm/view/authentication_views/forgot_pass_views/forgot_password_view.dart';
import 'package:uni_tribe/app/mvvm/view/authentication_views/forgot_pass_views/forgot_password_otp_view.dart';

import 'package:uni_tribe/app/mvvm/view/authentication_views/login_view/login_screen.dart';
import 'package:uni_tribe/app/mvvm/view/landing_views/landing_screen.dart';
// Import other screens as needed

import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppRoutes {
  AppRoutes._();
  
  // Define all your route paths
  static const landing = '/';
  static const loginScreen = '/loginScreen';
  static const forgotPasswordView = '/forgotPasswordView';
  static const forgotPasswordOtpView = '/forgotPasswordOtpView';
    static const forgotPasswordNewPassView = '/forgotPasswordNewPassView';

  static const registerScreen = '/registerScreen';
  static const homeScreen = '/homeScreen';
  // Add other routes as needed
}

abstract class AppPages {
  AppPages._();
  
  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.landing,
      page: () =>  LandingScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () =>  SignInScreen(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordView,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {}),
    ),
    // Add more routes here
    GetPage(
      name: AppRoutes.forgotPasswordOtpView,
      page: () => const ForgotPasswordOtpView(),
      binding: BindingsBuilder(() {}),
    ),
   
    // GetPage(
    //   name: AppRoutes.homeScreen,
    //   page: () => const HomeScreen(),
    //   binding: BindingsBuilder(() {}),
    // ),
  ];
}