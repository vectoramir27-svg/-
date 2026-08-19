import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'core/services/app_state.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/home/screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();

  runApp(const SpeaklyApp());
}

class SpeaklyApp extends StatefulWidget {
  const SpeaklyApp({super.key});

  @override
  State<SpeaklyApp> createState() => _SpeaklyAppState();
}

class _SpeaklyAppState extends State<SpeaklyApp> {
  @override
  void initState() {
    super.initState();
    AppState().addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isRegistered = StorageService().isRegistered;
    final appState = AppState();

    return MaterialApp(
      title: 'Speakly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: isRegistered ? const MainNavigationScreen() : const OnboardingScreen(),
    );
  }
}
