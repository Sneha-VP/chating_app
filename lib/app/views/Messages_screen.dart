import 'package:dating_app/app/util/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/messages_controller.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget with CacheManager {
  final MessagesController controller = Get.find<MessagesController>();

  final List<String> imageUrls = [
    "https://randomuser.me/api/portraits/men/2.jpg",
    "https://randomuser.me/api/portraits/men/4.jpg",
    "https://randomuser.me/api/portraits/men/6.jpg",
    "https://randomuser.me/api/portraits/women/5.jpg",
    "https://randomuser.me/api/portraits/women/7.jpg",
    "https://randomuser.me/api/portraits/men/8.jpg",
    "https://randomuser.me/api/portraits/women/9.jpg",
    "https://randomuser.me/api/portraits/men/10.jpg",
    "https://randomuser.me/api/portraits/women/1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Messages',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top horizontal profiles
            Container(
              height: 90,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.chatProfiles.length,
                separatorBuilder: (_, __) => SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final profile = controller.chatProfiles[index];
                  return GestureDetector(
                    onTap: () {
                      final profile = controller.chatProfiles[index];
                      Get.to(() => ChatScreen(
                            currentUserId: userId.toString(),
                            otherUserId: profile.id,
                            name: profile.name,
                            imageUrl: profile.image ??
                                imageUrls[index % imageUrls.length],
                          ));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          // backgroundImage: profile.image != null
                          //     ? NetworkImage(profile.image!)
                          //     : AssetImage('assets/default_avatar.png') as ImageProvider,

                          backgroundImage: profile.image != null
                              ? NetworkImage(profile.image!)
                              : NetworkImage(
                                  imageUrls[index % imageUrls.length]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          profile.name.split(" ").first,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            // Chat List label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Chat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            SizedBox(height: 8),

            // Chat list
            Expanded(
              child: ListView.separated(
                itemCount: controller.chatProfiles.length,
                separatorBuilder: (_, __) => Divider(indent: 72, endIndent: 16),
                itemBuilder: (context, index) {
                  final profile = controller.chatProfiles[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: CircleAvatar(
                      radius: 26,
                      // backgroundImage: profile.image != null
                      //     ? NetworkImage(profile.image!)
                      //     : AssetImage('assets/default_avatar.png') as ImageProvider,

                      backgroundImage: profile.image != null
                          ? NetworkImage(profile.image!)
                          : NetworkImage(imageUrls[index % imageUrls.length]),
                    ),
                    title: Text(
                      profile.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      profile.lastMessageTime ?? '10:00 AM',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {
                      final profile = controller.chatProfiles[index];
                      print("currentUserId==" + userId.toString());
                      print("otherUserId==" + profile.id);

                      Get.to(() => ChatScreen(
                            currentUserId: userId.toString(),
                            otherUserId: profile.id,
                            name: profile.name,
                            imageUrl: profile.image ??
                                imageUrls[index % imageUrls.length],
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
