import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../calls/screens/active_call_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  final String contactName;
  final String username;
  final String speaklyId;

  const ChatRoomScreen({
    super.key,
    required this.contactName,
    required this.username,
    required this.speaklyId,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"text": "Здравствуйте! Добро пожаловать в Speakly. Чем можем помочь?", "isMe": false, "type": "text"},
  ];

  void _sendMessage({String? text, String type = "text"}) {
    final msg = text ?? _msgController.text.trim();
    if (msg.isNotEmpty) {
      setState(() {
        _messages.add({"text": msg, "isMe": true, "type": type});
      });
      _msgController.clear();
      StorageService().addRatingPoints(1);
    }
  }

  void _attachImage() {
    _sendMessage(text: "📷 [Фотография зашифрована]", type: "image");
  }

  void _recordVoice() {
    _sendMessage(text: "🎤 Голосовое сообщение (0:07)", type: "voice");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.contactName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text("в сети", style: TextStyle(fontSize: 11, color: AppColors.successGreen)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primaryBlue),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ActiveCallScreen(contactName: widget.contactName, isVideo: false)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.primaryBlue),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ActiveCallScreen(contactName: widget.contactName, isVideo: true)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.black.withOpacity(0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock, size: 12, color: AppColors.textGray),
                SizedBox(width: 4),
                Text("Сообщения защищены сквозным шифрованием", style: TextStyle(fontSize: 11, color: AppColors.textGray)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, idx) {
                final item = _messages[idx];
                final isMe = item['isMe'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primaryBlue : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      item['text'],
                      style: TextStyle(color: isMe ? Colors.white : null, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primaryBlue, size: 28),
                    onPressed: _attachImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: "Сообщение...",
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: AppColors.primaryBlue),
                    onPressed: _recordVoice,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
