import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'core/services/security_service.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/home/screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация сервисов хранилища и защиты
  await StorageService().init();
  await SecurityService().enableScreenProtection();

  runApp(const SpeaklyApp());
}

class SpeaklyApp extends StatelessWidget {
  const SpeaklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isRegistered = StorageService().isRegistered;

    return MaterialApp(
      title: 'Speakly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isRegistered ? const MainNavigationScreen() : const OnboardingScreen(),
    );
  }
}