import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
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
  String? _firstPin;
  bool _isConfirm = false;

  void _handleNumber(String digit) {
    if (_pin.length < 4) {
      setState(() => _pin += digit);
      if (_pin.length == 4) {
        if (!_isConfirm) {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              _firstPin = _pin;
              _pin = "";
              _isConfirm = true;
            });
          });
        } else {
          if (_pin == _firstPin) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => BiometricsScreen(
                  username: widget.username,
                  displayName: widget.displayName,
                  speaklyId: widget.speaklyId,
                  pin: _pin,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PIN-коды не совпадают! Попробуйте снова.')),
            );
            setState(() {
              _pin = "";
              _isConfirm = false;
              _firstPin = null;
            });
          }
        }
      }
    }
  }

  void _backspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.bluePurpleGradient,
              ),
              child: const Icon(Icons.lock, color: Colors.white, size: 34),
            ),
            const SizedBox(height: 20),
            Text(
              _isConfirm ? "Подтвердите PIN" : "Создайте PIN-код",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "4-значный код для защиты аккаунта",
              style: TextStyle(color: AppColors.textGray, fontSize: 13),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length ? AppColors.primaryBlue : Colors.blue.shade50,
                  ),
                );
              }),
            ),
            const Spacer(),
            _buildNumpad(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    return Column(
      children: [
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [1, 2, 3].map((val) {
                int number = i * 3 + val;
                return _buildNumButton(number.toString());
              }).toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 80, height: 80),
              _buildNumButton("0"),
              InkWell(
                onTap: _backspace,
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  child: const Icon(Icons.backspace_outlined, color: AppColors.textDark),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumButton(String text) {
    return InkWell(
      onTap: () => _handleNumber(text),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }
}