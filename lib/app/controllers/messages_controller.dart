import 'package:get/get.dart';
import '../models/messages_model.dart';
import '../services/api_provider.dart';

class MessagesController extends GetxController {
  final ApiProvider apiProvider;

  MessagesController(this.apiProvider);

  var chatProfiles = <ChatProfileModel>[].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatProfiles();
  }

  void fetchChatProfiles() async {
    try {
      isLoading.value = true;
      final profiles = await apiProvider.getChatProfiles();
      chatProfiles.value = profiles;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
