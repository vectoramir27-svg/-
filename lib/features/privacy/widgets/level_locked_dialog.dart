import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LevelLockedDialog extends StatelessWidget {
  final int currentLevel;
  final int requiredLevel;
  final String featureName;

  const LevelLockedDialog({
    super.key,
    required this.currentLevel,
    required this.requiredLevel,
    required this.featureName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: const [
          Icon(Icons.lock_outline, color: Colors.orange),
          SizedBox(width: 8),
          Text("Функция заблокирована", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      content: Text(
        "Функция «$featureName» доступна только со $requiredLevel уровня рейтинга.\n\nВаш текущий уровень: $currentLevel.\nОбщайтесь в Speakly, чтобы повысить рейтинг!",
        style: const TextStyle(fontSize: 14, height: 1.4),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text("Понятно", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
