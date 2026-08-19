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
  String? _errorMessage;

  void _submit() {
    final text = _controller.text.trim().toLowerCase();
    final validRegex = RegExp(r'^[a-z0-9_]+$');

    if (text.length < 5) {
      setState(() => _errorMessage = "Юзернейм должен содержать минимум 5 символов");
      return;
    }

    if (!validRegex.hasMatch(text)) {
      setState(() => _errorMessage = "Допустимы только буквы (a-z), цифры и '_'");
      return;
    }

    setState(() => _errorMessage = null);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DisplayNameScreen(username: text)),
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
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                alignment: Alignment.center,
                child: const Text("@", style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              ),
              const SizedBox(height: 24),
              const Text("Создайте имя пользователя", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Минимум 5 символов (латиница, цифры, _).\nБез номера телефона и почты.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 13),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "username (от 5 букв)",
                  errorText: _errorMessage,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                ),
                onChanged: (_) {
                  if (_errorMessage != null) setState(() => _errorMessage = null);
                },
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
