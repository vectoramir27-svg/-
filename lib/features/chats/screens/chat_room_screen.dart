import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';

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
  final List<String> _messages = [
    "Здравствуйте! Добро пожаловать в Speakly. Чем можем помочь?",
  ];

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(text);
      });
      _msgController.clear();
      // Начисляем 1 очко за сообщение согласно логике геймификации
      StorageService().addRatingPoints(1);
    }
  }

  void _showUserProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Профиль", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Готово", style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.headset_mic, size: 40, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 12),
            Text(widget.contactName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("@${widget.username}", style: const TextStyle(color: AppColors.textGray)),
            const Text("в сети", style: TextStyle(color: AppColors.successGreen, fontSize: 12)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.fingerprint, color: AppColors.primaryBlue),
                      const SizedBox(width: 8),
                      const Text("SpeaklyID"),
                      const Spacer(),
                      Text(widget.speaklyId, style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: const [
                      Icon(Icons.calendar_today_outlined, color: AppColors.primaryBlue, size: 20),
                      SizedBox(width: 8),
                      Text("Дата регистрации"),
                      Spacer(),
                      Text("19 августа 2026 г.", style: TextStyle(color: AppColors.textGray)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _showUserProfileModal,
          child: Column(
            children: [
              Text(widget.contactName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text("в сети", style: TextStyle(fontSize: 11, color: AppColors.successGreen)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined),
            onPressed: _showUserProfileModal,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            color: Colors.grey.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock, size: 12, color: AppColors.textGray),
                SizedBox(width: 4),
                Text(
                  "Сообщения защищены сквозным шифрованием.",
                  style: TextStyle(fontSize: 11, color: AppColors.textGray),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, idx) {
                final isMe = idx > 0;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primaryBlue : AppColors.cardLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _messages[idx],
                      style: TextStyle(color: isMe ? Colors.white : AppColors.textDark, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primaryBlue, size: 28),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: "Сообщение...",
                        hintStyle: const TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.cardLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: AppColors.primaryBlue),
                    onPressed: () {},
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