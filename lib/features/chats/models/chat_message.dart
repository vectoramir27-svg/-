class ChatMessage {
  final String id;
  final String senderId;
  final String recipientId;
  final String text;
  final DateTime timestamp;
  final bool isEncrypted;
  final bool isRead;
  final bool isGhost;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.timestamp,
    this.isEncrypted = true,
    this.isRead = false,
    this.isGhost = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'recipientId': recipientId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isEncrypted': isEncrypted,
      'isRead': isRead,
      'isGhost': isGhost,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      recipientId: map['recipientId'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      isEncrypted: map['isEncrypted'] ?? true,
      isRead: map['isRead'] ?? false,
      isGhost: map['isGhost'] ?? false,
    );
  }
}