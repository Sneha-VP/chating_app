import 'package:dating_app/app/controllers/phone_number_controller.dart';
import 'package:get/get.dart';

import '../views/phone_number_screen.dart';

class SplashController extends GetxController {
  void signInWithFacebook() {
    Get.snackbar("Facebook", "Facebook sign-in clicked");
  }

  void signInWithPhone() {
    Get.put(AuthController());
    Get.to(() => const PhoneNumberScreen());
  }

  void signInWithGoogle() {
    Get.snackbar("Google", "Google sign-in clicked");
  }
}
