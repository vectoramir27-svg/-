import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final int _bonusPoints = 1000;

  void _givePoints() async {
    await StorageService().addRatingPoints(_bonusPoints);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Начислено +$_bonusPoints очков рейтинга!')),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentPoints = StorageService().ratingPoints;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Админ-панель Speakly"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: const [
                Icon(Icons.security, color: Colors.red, size: 30),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Режим главного администратора активен.\nВам доступны все системные привилегии.",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Управление очками и уровнями", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: Text("Текущие очки: $currentPoints"),
            subtitle: const Text("Разблокировать 2 уровень (требуется 5000)"),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(110, 40)),
              onPressed: _givePoints,
              child: const Text("+1000 очков"),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Системные логи", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("• Сервер сквозного шифрования: ONLINE", style: TextStyle(color: Colors.green, fontSize: 13)),
                SizedBox(height: 4),
                Text("• WebSocket Gateway: v1.4 CONNECTED", style: TextStyle(color: Colors.green, fontSize: 13)),
                SizedBox(height: 4),
                Text("• Активных E2EE комнат: 12", style: TextStyle(fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
