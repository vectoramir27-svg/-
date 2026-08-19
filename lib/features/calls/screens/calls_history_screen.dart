import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CallsHistoryScreen extends StatelessWidget {
  const CallsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Вызовы", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.phone_missed_outlined, size: 64, color: AppColors.textMuted),
            SizedBox(height: 16),
            Text("Нет вызовов", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(
              "Здесь будет история ваших звонков",
              style: TextStyle(color: AppColors.textGray, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}