class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime? sentAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    return ChatMessage(
      id: int.tryParse(json['id'].toString()) ?? 0,
      senderId: attributes['sender_id'] ?? 0,
      receiverId: attributes['receiver_id'] ?? 0,
      message: attributes['message'] ?? '',
      sentAt: DateTime.tryParse(attributes['sent_at'] ?? ''),
    );
  }
}
