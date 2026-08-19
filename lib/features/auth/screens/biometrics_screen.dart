import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/security_service.dart';
import '../../home/screens/main_navigation_screen.dart';

class BiometricsScreen extends StatelessWidget {
  final String username;
  final String displayName;
  final String speaklyId;
  final String pin;

  const BiometricsScreen({
    super.key,
    required this.username,
    required this.displayName,
    required this.speaklyId,
    required this.pin,
  });

  Future<void> _completeRegistration(BuildContext context, bool useBiometrics) async {
    final storage = StorageService();
    await storage.saveUserData(
      username: username,
      displayName: displayName,
      speaklyId: speaklyId,
    );
    await storage.savePin(pin);

    if (useBiometrics) {
      await SecurityService().authenticateWithBiometrics();
    }

    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                ),
                child: const Icon(Icons.face_retouching_natural, size: 50, color: AppColors.successGreen),
              ),
              const SizedBox(height: 28),
              const Text("Настроить Face ID?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Быстрый и безопасный вход\nс помощью биометрии",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 14),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _completeRegistration(context, true),
                child: const Text("Настроить"),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _completeRegistration(context, false),
                child: const Text("Пропустить", style: TextStyle(color: AppColors.textGray, fontSize: 14)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}