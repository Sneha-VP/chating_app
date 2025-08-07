// lib/app/routes/app_pages.dart
import 'package:dating_app/app/bindings/chat_binding.dart';
import 'package:dating_app/app/bindings/phone_number_binding.dart';
import 'package:dating_app/app/views/Messages_screen.dart';
import 'package:dating_app/app/views/chat_screen.dart';
import 'package:dating_app/app/views/initial_splash.dart';
import 'package:dating_app/app/views/phone_number_screen.dart';
import 'package:get/get.dart';
import '../bindings/initial_splash_biding.dart';
import '../bindings/messages_binding.dart';
import '../bindings/otp_binding.dart';
import '../bindings/splash_biding.dart';
import '../views/otp_screen.dart';
import '../views/splash_screen.dart';

class Routes {
  static const initialSplash = '/initialSplash';
  static const splash = '/splash';
  static const phone = '/phone';
  static const otp = '/otp';
  static const messages = '/messages';
  static const chat = '/chat';
}

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.initialSplash,
      page: () => InitialSplashScreen(),
      binding: InitialSplashBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.phone,
      page: () => const PhoneNumberScreen(),
      binding: PhoneNumberBinding(),
    ),
    GetPage(
      name: '/otp',
      page: () =>
          OtpScreen(phone: ''), // default phone, overridden during navigation
      binding: OtpBinding(),
    ),
    GetPage(
      name: '/messages',
      page: () =>
          MessagesScreen(), // default phone, overridden during navigation
      binding: MessagesBinding(),
    ),
    GetPage(
      name: '/chat',
      page: () => ChatScreen(
          currentUserId: "",
          otherUserId: "",
          name: "",
          imageUrl: ""), // default phone, overridden during navigation
      binding: ChatBiding(),
    ),
  ];
}
