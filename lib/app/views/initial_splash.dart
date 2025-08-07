import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/initial_splash_controller.dart';


class InitialSplashScreen extends StatelessWidget {
  InitialSplashScreen({Key? key}) : super(key: key);

  final InitialSplashController controller = Get.put(InitialSplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
           CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white10,
          child: Icon(Icons.favorite, color: Colors.pink, size: 50),
        ),
            SizedBox(height: 20),
            Text(
              "Welcome to ChatApp",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
