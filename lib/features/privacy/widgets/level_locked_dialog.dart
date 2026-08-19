import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LevelLockedDialog extends StatelessWidget {
  final int currentPoints;

  const LevelLockedDialog({super.key, required this.currentPoints});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.shade50,
              ),
              child: const Icon(Icons.lock, color: AppColors.warningOrange, size: 32),
            ),
            const SizedBox(height: 16),
            const Text("Функция заблокирована", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Требуется 2 уровень рейтинга", style: TextStyle(color: AppColors.textGray, fontSize: 13)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ваш рейтинг", style: TextStyle(fontSize: 13)),
                Text("$currentPoints / 5,000", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: currentPoints / 5000,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Как заработать очки", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.primaryBlue),
                SizedBox(width: 8),
                Text("Отправить сообщение = 1 очко", style: TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Icon(Icons.star_outline, size: 16, color: Colors.amber),
                SizedBox(width: 8),
                Text("Для 2 уровня нужно 5 000 очков", style: TextStyle(fontSize: 13)),
              ],
            ),
            const Divider(height: 28),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Будет доступно", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(height: 10),
            _featureItem("Режим призрака"),
            _featureItem("Маскировка IP"),
            _featureItem("Стелс клавиатура"),
            _featureItem("Decoy PIN"),
            _featureItem("Самоуничтожение профиля"),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Понятно"),
            )
          ],
        ),
      ),
    );
  }

  Widget _featureItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, size: 14, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(color: AppColors.textGray, fontSize: 13)),
        ],
      ),
    );
  }
}