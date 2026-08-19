import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/app_state.dart';
import 'active_call_screen.dart';

class CallsHistoryScreen extends StatelessWidget {
  const CallsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState();

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(appState.tr('calls'), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_call, color: AppColors.primaryBlue),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ActiveCallScreen(contactName: "Speakly Support"),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_missed_outlined, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(appState.tr('no_calls'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              appState.tr('no_calls_desc'),
              style: const TextStyle(color: AppColors.textGray, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
