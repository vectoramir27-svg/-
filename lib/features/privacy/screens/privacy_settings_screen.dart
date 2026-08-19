import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/security_service.dart';
import '../widgets/level_locked_dialog.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _onlineStatus = true;
  bool _lastSeen = true;
  bool _readReceipts = true;
  bool _hideTyping = true;

  bool _blockScreenshots = true;
  bool _denyForwarding = false;
  bool _phantomMessages = false;

  void _openLockedDialog() {
    showDialog(
      context: context,
      builder: (_) => LevelLockedDialog(
        currentPoints: StorageService().ratingPoints,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Конфиденциальность"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Баннер "Режим призрака"
          GestureDetector(
            onTap: _openLockedDialog,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.visibility_off_outlined, color: AppColors.warningOrange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Режим призрака", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("Полная невидимость в сети", style: TextStyle(color: AppColors.textGray, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.warningOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Уровень 2", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Видимость", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
          _buildSwitchTile(Icons.remove_red_eye_outlined, "Статус онлайн", _onlineStatus, (v) => setState(() => _onlineStatus = v)),
          _buildSwitchTile(Icons.access_time, "Последний визит", _lastSeen, (v) => setState(() => _lastSeen = v)),
          _buildSwitchTile(Icons.done_all, "Отчёты о прочтении", _readReceipts, (v) => setState(() => _readReceipts = v)),
          _buildSwitchTile(Icons.keyboard_outlined, "Скрыть набор текста", _hideTyping, (v) => setState(() => _hideTyping = v)),
          const SizedBox(height: 20),
          const Text("Защита контента", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
          _buildSwitchTile(Icons.screenshot_outlined, "Блокировка скриншотов", _blockScreenshots, (v) {
            setState(() => _blockScreenshots = v);
            if (v) {
              SecurityService().enableScreenProtection();
            } else {
              SecurityService().disableScreenProtection();
            }
          }),
          _buildSwitchTile(Icons.forward_outlined, "Запрет пересылки", _denyForwarding, (v) => setState(() => _denyForwarding = v)),
          _buildSwitchTile(Icons.timer_outlined, "Фантомные сообщения", _phantomMessages, (v) => setState(() => _phantomMessages = v)),
          const SizedBox(height: 20),
          const Text("Автоудаление", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text("Сообщения будут автоматически удалены через:", style: TextStyle(color: AppColors.textGray, fontSize: 12)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: const Text("Никогда", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: Switch(
          value: value,
          activeColor: AppColors.primaryBlue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}