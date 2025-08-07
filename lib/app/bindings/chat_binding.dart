import 'package:dating_app/app/controllers/chat_controller.dart';
import 'package:get/get.dart';

class ChatBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController(currentUserId: 0, otherUserId: 0));
  }
}
