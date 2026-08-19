import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/screens/username_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  String _selectedLang = 'EN';
  bool _isDarkMode = false;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.flash_on,
      'gradient': AppColors.bluePurpleGradient,
      'title': 'Добро пожаловать\nв Speakly',
      'desc': 'Мессенджер нового поколения\nс максимальной конфиденциальностью',
      'letter': 'S'
    },
    {
      'icon': Icons.lock_outline,
      'gradient': AppColors.shieldGradient,
      'title': 'Шифрование\nот начала до конца',
      'desc': 'Все сообщения защищены\nсквозным шифрованием.\nНикто не может прочитать ваши данные',
      'letter': null
    },
    {
      'icon': Icons.visibility_off_outlined,
      'gradient': AppColors.ghostGradient,
      'title': 'Ghost Mode',
      'desc': 'Станьте невидимым.\nНикто не узнает, что вы онлайн,\nчитаете сообщения или печатаете',
      'letter': null
    },
    {
      'icon': Icons.local_fire_department_outlined,
      'gradient': AppColors.fenixGradient,
      'title': 'Протокол Fenix',
      'desc': 'Одно нажатие — и все ваши данные\nбудут безвозвратно удалены\nс наших серверов',
      'letter': null
    },
    {
      'icon': Icons.fingerprint,
      'gradient': AppColors.bluePurpleGradient,
      'title': 'SpeaklyID',
      'desc': 'Никаких телефонов и почты.\nТолько ваш уникальный SpeaklyID\nи PIN-код для входа',
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const UsernameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя панель переключателей Языка и Темы
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLang = _selectedLang == 'EN' ? 'RU' : 'EN';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.cardLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language, size: 16, color: AppColors.primaryBlue),
                          const SizedBox(width: 4),
                          Text(_selectedLang, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round, color: AppColors.primaryBlue),
                    onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
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
                          item['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          item['desc'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, color: AppColors.textGray, height: 1.4),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Индикаторы страниц (точки)
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: _nextPage,
                child: Text(_currentPage == _pages.length - 1 ? 'Начать' : 'Далее'),
              ),
            ),
            const SizedBox(height: 12),
            if (_currentPage < _pages.length - 1)
              TextButton(
                onPressed: _goToRegister,
                child: const Text('Пропустить', style: TextStyle(color: AppColors.textGray, fontSize: 14)),
              )
            else
              const SizedBox(height: 48),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}