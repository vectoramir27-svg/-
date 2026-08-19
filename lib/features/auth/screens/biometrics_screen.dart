import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/screens/main_navigation_screen.dart';

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({super.key});

  void _finish(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.face_unlock_outlined, size: 44, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 24),
              const Text("Быстрый вход", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Используйте биометрию для мгновенной разблокировки диалогов",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 13),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _finish(context),
                child: const Text("Включить биометрию"),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _finish(context),
                child: const Text("Пропустить", style: TextStyle(color: AppColors.textGray)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
