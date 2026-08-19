import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../chats/screens/chats_list_screen.dart';
import '../../calls/screens/calls_history_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ChatsListScreen(),
    CallsHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textGray,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Badge(
              label: Text("1"),
              child: Icon(Icons.chat_bubble_rounded),
            ),
            label: "Чаты",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: "Вызовы",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
        ],
      ),
    );
  }
}