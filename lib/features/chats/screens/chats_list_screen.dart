import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'chat_room_screen.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Чаты", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note, size: 28, color: AppColors.primaryBlue),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // Поисковая строка
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Поиск по юзернейму",
                hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.cardLight,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Закрепленный блок "Обращения в поддержку"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: const [
                Icon(Icons.headset_mic_outlined, size: 18, color: AppColors.primaryBlue),
                SizedBox(width: 8),
                Text(
                  "Обращения в поддержку",
                  style: TextStyle(color: AppColors.textGray, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          // Список чатов
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ChatRoomScreen(
                          contactName: "Speakly Support",
                          username: "speakly_support",
                          speaklyId: "SPK-SUPPORT",
                        ),
                      ),
                    );
                  },
                  leading: Stack(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade50,
                        ),
                        child: const Icon(Icons.headset_mic, color: AppColors.primaryBlue, size: 26),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.successGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      )
                    ],
                  ),
                  title: Row(
                    children: const [
                      Text("Speakly Support", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(width: 4),
                      Icon(Icons.verified, color: AppColors.primaryBlue, size: 16),
                    ],
                  ),
                  subtitle: const Text(
                    "Здравствуйте! Добро пожаловать...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.textGray, fontSize: 13),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Text("1", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}