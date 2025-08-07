import 'package:get/get.dart';
import '../controllers/messages_controller.dart';
import '../services/api_provider.dart';

class MessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider()); // Provide ApiProvider
    Get.lazyPut<MessagesController>(() => MessagesController(Get.find<ApiProvider>()));
  }
}
