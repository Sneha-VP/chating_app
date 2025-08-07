class ChatProfileModel {
  final String id;
  final String name;
  final String? image;
  final String? lastMessage;
  final String? lastMessageTime;

  ChatProfileModel({
    required this.id,
    required this.name,
    this.image,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatProfileModel.fromJson(Map<String, dynamic> json) {
    return ChatProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "last_message": lastMessage,
      "last_message_time": lastMessageTime,
    };
  }
}
