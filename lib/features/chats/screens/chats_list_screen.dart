import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/app_state.dart';
import 'chat_room_screen.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final appState = AppState();

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(appState.tr('chats'), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: "Поиск по юзернейму...",
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(_searchQuery.substring(0, 1).toUpperCase()),
              ),
              title: Text("@$_searchQuery"),
              subtitle: const Text("Начать новый секретный диалог"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatRoomScreen(
                      contactName: _searchQuery,
                      username: _searchQuery,
                      speaklyId: "SPK-${_searchQuery.toUpperCase()}",
                    ),
                  ),
                );
              },
            )
          else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: const [
                  Icon(Icons.headset_mic_outlined, size: 18, color: AppColors.primaryBlue),
                  SizedBox(width: 8),
                  Text("Обращения в поддержку", style: TextStyle(color: AppColors.textGray, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      appState.markSupportAsRead();
                      setState(() {});
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
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade50),
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
                    subtitle: const Text("Здравствуйте! Чем можем помочь?", maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: !appState.isSupportRead
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                            child: const Text("1", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
