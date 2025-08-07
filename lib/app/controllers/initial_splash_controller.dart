import 'dart:async';
import 'package:get/get.dart';

import '../util/cache_manager.dart';


class InitialSplashController extends GetxController with CacheManager {
  @override
  void onInit() {
    super.onInit();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Timer(const Duration(seconds: 3), _checkLoginStatus);
  }

  void _checkLoginStatus() {

    if (token == null || token!.isEmpty) {
      print("initial token=="+token.toString());
      Get.offAllNamed('/splash'); // Navigate to login
    } else {
      Get.offAllNamed('/messages'); // Navigate to chat
    }
  }
}
