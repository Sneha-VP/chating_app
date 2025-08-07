
import 'package:dating_app/app/controllers/initial_splash_controller.dart';
import 'package:get/get.dart';

class InitialSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitialSplashController>(() => InitialSplashController());
  }
}
