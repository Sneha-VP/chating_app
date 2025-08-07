import 'package:dating_app/app/util/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japx/japx.dart';

import '../models/auth_model.dart';
import '../services/api_provider.dart';
import '../views/otp_screen.dart';
import '../views/messages_screen.dart';
import 'messages_controller.dart';

class AuthController extends GetxController with CacheManager {
  final phoneController = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();

  var isLoading = false.obs;
  var isOtpSent = false.obs;
  String? accessToken;

  ///  Send OTP to entered phone number
  void sendOtp() async {
    var phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      Get.snackbar("Invalid", "Please enter a valid phone number");
      return;
    }

    // Ensure phone has +91
    if (!phone.startsWith("+")) {
      phone = "+91$phone";
    }

    isLoading.value = true;

    try {
      final response = await _apiProvider.sendOtp(phone);
      final Map<String, dynamic> raw = response.data;

      if (raw['status'] == true) {
        isOtpSent.value = true;
        Get.snackbar("Success", "OTP sent successfully");
        Get.to(() => OtpScreen(phone: phone));
      } else {
        Get.snackbar("Error", raw['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  ///  Verify OTP

  Future<void> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final result = await _apiProvider.verifyOtp(phone: phone, otp: otp);

      final model = OtpResponseModel.fromJson(result);
      accessToken = model.authStatus.accessToken;

      // ✅ Set token for future requests
      _apiProvider.setToken(accessToken!);

      Get.snackbar("Success", "OTP Verified");
      print("Access Token: $accessToken");
      print("User ID: ${model.id}");
      saveUserId(model.id);
      saveToken(accessToken);
      if (accessToken == null) {
        print("verification failed");
      } else {
        Get.put(MessagesController(_apiProvider));
        Get.to(() => MessagesScreen());
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      Get.snackbar("Error", "OTP verification failed");
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
