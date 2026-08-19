import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ActiveCallScreen extends StatefulWidget {
  final String contactName;
  final bool isVideo;

  const ActiveCallScreen({super.key, required this.contactName, this.isVideo = false});

  @override
  State<ActiveCallScreen> createState() => _ActiveCallScreenState();
}

class _ActiveCallScreenState extends State<ActiveCallScreen> {
  int _seconds = 0;
  Timer? _timer;
  bool _isMuted = false;
  bool _isSpeaker = true;
  bool _isCameraOn = true;

  @override
  void initState() {
    super.initState();
    _isCameraOn = widget.isVideo;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14171D),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              widget.contactName,
              style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.isVideo ? "Защищенный видеозвонок • ${_formatDuration(_seconds)}" : "Защищенный аудиозвонок • ${_formatDuration(_seconds)}",
              style: const TextStyle(color: AppColors.textGray, fontSize: 14),
            ),
            const Spacer(),
            // Анимированный аватар собеседника
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade900.withOpacity(0.4),
                border: Border.all(color: AppColors.primaryBlue.withOpacity(0.5), width: 3),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const Spacer(),
            // Кнопки управления звонком
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _callButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    color: _isMuted ? Colors.white : Colors.white24,
                    iconColor: _isMuted ? Colors.black : Colors.white,
                    onTap: () => setState(() => _isMuted = !_isMuted),
                  ),
                  if (widget.isVideo)
                    _callButton(
                      icon: _isCameraOn ? Icons.videocam : Icons.videocam_off,
                      color: _isCameraOn ? Colors.white24 : Colors.white,
                      iconColor: _isCameraOn ? Colors.white : Colors.black,
                      onTap: () => setState(() => _isCameraOn = !_isCameraOn),
                    ),
                  _callButton(
                    icon: Icons.call_end,
                    color: AppColors.dangerRed,
                    iconColor: Colors.white,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _callButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}
