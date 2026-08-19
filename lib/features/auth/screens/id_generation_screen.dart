import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'pin_setup_screen.dart';

class IdGenerationScreen extends StatefulWidget {
  final String username;
  final String displayName;

  const IdGenerationScreen({
    super.key,
    required this.username,
    required this.displayName,
  });

  @override
  State<IdGenerationScreen> createState() => _IdGenerationScreenState();
}

class _IdGenerationScreenState extends State<IdGenerationScreen> {
  late String _speaklyId;

  @override
  void initState() {
    super.initState();
    _speaklyId = _generateId();
  }

  String _generateId() {
    const chars = '0123456789ABCDEF';
    final rnd = Random();
    final buffer = StringBuffer('SPK-');
    for (var i = 0; i < 8; i++) {
      buffer.write(chars[rnd.nextInt(chars.length)]);
    }
    return buffer.toString();
  }

  void _next() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PinSetupScreen(
          username: widget.username,
          displayName: widget.displayName,
          speaklyId: _speaklyId,
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
              const SizedBox(height: 40),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                child: const Icon(Icons.fingerprint, size: 60, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 28),
              const Text("Ваш SpeaklyID", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _speaklyId,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Запомните ваш SpeaklyID.\nОн понадобится для входа в аккаунт.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 13, height: 1.4),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _next,
                child: const Text("Продолжить"),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}