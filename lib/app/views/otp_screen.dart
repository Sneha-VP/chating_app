import 'package:dating_app/app/views/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/phone_number_controller.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  OtpScreen({required this.phone, Key? key}) : super(key: key);

  final AuthController _authController = Get.find();
  final RxList<String> otpDigits = List.generate(6, (_) => "").obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                BackButton(color: Colors.black),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Enter your verification code",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "$phone. ",
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 16),
                                children: const [
                                  TextSpan(
                                    text: "Edit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(6, (index) {
                                return SizedBox(
                                  width: 40,
                                  child: OtpInput(
                                    onChanged: (value) {
                                      otpDigits[index] = value;
                                    },
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              "Didn't get anything? No worries, let’s try again.",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                              onPressed: () {
                                // Resend OTP logic
                              },
                              child: const Text(
                                "Resent",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// BOTTOM BUTTON
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              final otp = otpDigits.join();
                              _authController.verifyOtp(phone: phone, otp: otp);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF6A9F),
                                    Color(0xFFFF5477)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.pink.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Verify",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
