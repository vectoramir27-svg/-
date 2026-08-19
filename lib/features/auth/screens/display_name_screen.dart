import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'id_generation_screen.dart';

class DisplayNameScreen extends StatefulWidget {
  final String username;

  const DisplayNameScreen({super.key, required this.username});

  @override
  State<DisplayNameScreen> createState() => _DisplayNameScreenState();
}

class _DisplayNameScreenState extends State<DisplayNameScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IdGenerationScreen(
          username: widget.username,
          displayName: text,
        ),
      ),
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
                child: const Icon(Icons.person_outline, size: 40, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 24),
              const Text("Как вас зовут?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Это имя будут видеть ваши собеседники",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 13),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Ваше имя (или псевдоним)",
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
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
