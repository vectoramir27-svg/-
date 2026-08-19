import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'display_name_screen.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.length >= 3) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => DisplayNameScreen(username: text)),
      );
    }
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
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "@",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Создайте имя пользователя", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Это ваш уникальный идентификатор в Speakly.\nБез номера телефона, без почты.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 13),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Имя пользователя",
                  hintStyle: const TextStyle(color: AppColors.textMuted),
                  filled: true,
                  fillColor: AppColors.cardLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                ),
                onSubmitted: (_) => _submit(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Далее"),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}