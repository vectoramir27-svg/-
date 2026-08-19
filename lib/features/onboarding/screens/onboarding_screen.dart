import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/app_state.dart';
import '../../auth/screens/username_screen.dart';
import '../../auth/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.flash_on,
      'gradient': AppColors.bluePurpleGradient,
      'title': 'Добро пожаловать\nв Speakly',
      'title_en': 'Welcome to\nSpeakly',
      'desc': 'Мессенджер нового поколения\nс максимальной конфиденциальностью',
      'desc_en': 'Next-generation messenger\nwith maximum privacy',
      'letter': 'S'
    },
    {
      'icon': Icons.lock_outline,
      'gradient': AppColors.shieldGradient,
      'title': 'Шифрование\nот начала до конца',
      'title_en': 'End-to-End\nEncryption',
      'desc': 'Все сообщения защищены\nсквозным шифрованием.\nНикто не может прочитать ваши данные',
      'desc_en': 'All messages are protected.\nNo one can read your private data',
      'letter': null
    },
    {
      'icon': Icons.visibility_off_outlined,
      'gradient': AppColors.ghostGradient,
      'title': 'Ghost Mode',
      'title_en': 'Ghost Mode',
      'desc': 'Станьте невидимым.\nНикто не узнает, что вы онлайн,\nчитаете сообщения или печатаете',
      'desc_en': 'Become invisible.\nNo one sees your online or typing status',
      'letter': null
    },
    {
      'icon': Icons.local_fire_department_outlined,
      'gradient': AppColors.fenixGradient,
      'title': 'Протокол Fenix',
      'title_en': 'Fenix Protocol',
      'desc': 'Одно нажатие — и все ваши данные\nбудут безвозвратно удалены\nс наших серверов',
      'desc_en': 'One tap and all your data\nwill be permanently destroyed',
      'letter': null
    },
    {
      'icon': Icons.fingerprint,
      'gradient': AppColors.bluePurpleGradient,
      'title': 'SpeaklyID',
      'title_en': 'SpeaklyID',
      'desc': 'Никаких телефонов и почты.\nТолько ваш уникальный SpeaklyID\nи PIN-код для входа',
      'desc_en': 'No phone number or email required.\nOnly unique SpeaklyID & PIN',
      'letter': null
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToRegister();
    }
  }

  void _goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UsernameScreen()),
    );
  }

  void _goToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    final isRu = appState.currentLocale == 'RU';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => appState.toggleLocale()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language, size: 16, color: AppColors.primaryBlue),
                          const SizedBox(width: 6),
                          Text(appState.currentLocale, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(appState.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round, color: AppColors.primaryBlue),
                    onPressed: () => setState(() => appState.toggleTheme()),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemCount: _pages.length,
                itemBuilder: (ctx, idx) {
                  final item = _pages[idx];
                  final title = isRu ? item['title'] : item['title_en'];
                  final desc = isRu ? item['desc'] : item['desc_en'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: item['gradient'] as LinearGradient,
                          ),
                          alignment: Alignment.center,
                          child: item['letter'] != null
                              ? Text(
                                  item['letter'],
                                  style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold),
                                )
                              : Icon(item['icon'] as IconData, size: 48, color: Colors.white),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          desc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, color: AppColors.textGray, height: 1.4),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (idx) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == idx ? AppColors.primaryBlue : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _nextPage,
                    child: Text(_currentPage == _pages.length - 1 ? appState.tr('start') : appState.tr('next')),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _goToLogin,
                    child: Text(
                      appState.tr('login_btn'),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
