import 'package:get/get.dart';
import '../models/chat_model.dart';
import '../services/api_provider.dart';

class ChatController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;

  final ApiProvider _apiProvider = ApiProvider();

  final int currentUserId;
  final int otherUserId;

  ChatController({
    required this.currentUserId,
    required this.otherUserId,
  });

  @override
  void onInit() {
    super.onInit();
    fetchChatMessages(currentUserId, otherUserId);
  }

  Future<void> fetchChatMessages(int user1, int user2) async {
    isLoading.value = true;
    try {
      print("user1==$user1, user2==$user2");
      final fetchedMessages = await _apiProvider.fetchChatMessages(user1, user2);
      messages.assignAll(fetchedMessages);
      print("fetchedMessages==${fetchedMessages.toString()}");
    } catch (e) {
      print('Error fetching chat messages: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
