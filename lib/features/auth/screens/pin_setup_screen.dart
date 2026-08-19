import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import 'biometrics_screen.dart';

class PinSetupScreen extends StatefulWidget {
  final String username;
  final String displayName;
  final String speaklyId;

  const PinSetupScreen({
    super.key,
    required this.username,
    required this.displayName,
    required this.speaklyId,
  });

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  String _pin = "";

  void _onKeyTap(String val) {
    if (_pin.length < 4) {
      setState(() => _pin += val);
      if (_pin.length == 4) {
        _finishRegistration();
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  void _finishRegistration() async {
    final storage = StorageService();
    await storage.saveUserData(
      username: widget.username,
      displayName: widget.displayName,
      speaklyId: widget.speaklyId,
    );
    await storage.savePin(_pin);

    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BiometricsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Создайте PIN-код",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Для защиты входа в приложение",
              style: TextStyle(color: AppColors.textGray, fontSize: 13),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isFilled = index < _pin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? AppColors.primaryBlue : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            const Spacer(),
            for (var row in [
              ['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9'],
              ['', '0', '<']
            ])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row.map((char) {
                    if (char.isEmpty) {
                      return const SizedBox(width: 72, height: 72);
                    }
                    if (char == '<') {
                      return InkWell(
                        onTap: _onBackspace,
                        borderRadius: BorderRadius.circular(36),
                        child: Container(
                          width: 72,
                          height: 72,
                          alignment: Alignment.center,
                          child: const Icon(Icons.backspace_outlined, size: 24),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () => _onKeyTap(char),
                      borderRadius: BorderRadius.circular(36),
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          char,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
