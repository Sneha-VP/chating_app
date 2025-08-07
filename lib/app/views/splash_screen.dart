import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splash_couple.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite, color: Colors.pink, size: 30),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Connect. Meet. Love.\nWith Fliq Dating",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 280),

                    // Facebook Sign In
                    buildSocialButton(
                      iconPath: "assets/google_logo.png",
                      text: "Sign in with Google",
                      bgColor: Colors.white,
                      textColor: Colors.black,
                      onPressed: controller.signInWithGoogle,
                    ),
                    const SizedBox(height: 15),

                    // Facebook Sign In
                    buildSocialButton(
                      iconPath: "assets/facebook_logo.png",
                      text: "Sign in with Facebook",
                      bgColor: const Color(0xFF1877F2),
                      textColor: Colors.white,
                      onPressed: controller.signInWithFacebook,
                    ),
                    const SizedBox(height: 15),

                    // Phone Sign In
                    buildSocialButton(
                      iconData: Icons.phone,
                      text: "Sign in with phone number",
                      bgColor: const Color(0xFFd93065),
                      textColor: Colors.white,
                      onPressed: controller.signInWithPhone,
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      "By signing up, you agree to our Terms. See how we use your data in our Privacy Policy.",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSocialButton({
    String? iconPath,
    IconData? iconData,
    required String text,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        icon: iconPath != null
            ? Image.asset(iconPath, height: 22)
            : Icon(iconData, color: textColor),
        label: Text(text, style: TextStyle(color: textColor)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
