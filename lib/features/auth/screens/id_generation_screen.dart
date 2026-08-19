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
    _speaklyId = _generateSpeaklyId();
  }

  String _generateSpeaklyId() {
    const chars = '0123456789ABCDEFGHJKLMNPQRSTUVWXYZ';
    final random = Random.secure();
    final buffer = StringBuffer('SPK-');
    for (int i = 0; i < 8; i++) {
      buffer.write(chars[random.nextInt(chars.length)]);
    }
    return buffer.toString();
  }

  void _submit() {
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
              const SizedBox(height: 20),
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.fingerprint, size: 42, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 24),
              const Text("Ваш уникальный SpeaklyID", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "Используйте его для входа и поиска контактов без номера телефона",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGray, fontSize: 13),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
                ),
                alignment: Alignment.center,
                child: Text(
                  _speaklyId,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submit,
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
