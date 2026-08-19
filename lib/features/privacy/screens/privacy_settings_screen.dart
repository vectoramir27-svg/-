import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/security_service.dart';
import '../../../core/services/storage_service.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  final SecurityService _security = SecurityService();
  bool _ghostMode = false;
  bool _screenProtection = true;
  bool _biometrics = true;

  @override
  void initState() {
    super.initState();
    _ghostMode = _security.isGhostMode;
    _screenProtection = _security.isScreenshotProtected;
  }

  @override
  Widget build(BuildContext context) {
    final cardBg = Theme.of(context).colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Конфиденциальность"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.visibility_off_outlined, color: AppColors.primaryBlue),
                  title: const Text("Ghost Mode", style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text("Скрыть сетевой статус и отчеты о прочтении", style: TextStyle(fontSize: 12)),
                  value: _ghostMode,
                  onChanged: (val) {
                    setState(() => _ghostMode = val);
                    _security.toggleGhostMode(val);
                  },
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.camera_alt_outlined, color: AppColors.primaryBlue),
                  title: const Text("Защита от скриншотов", style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text("Блокировать запись экрана и снимки", style: TextStyle(fontSize: 12)),
                  value: _screenProtection,
                  onChanged: (val) {
                    setState(() => _screenProtection = val);
                    if (val) {
                      _security.enableScreenProtection();
                    } else {
                      _security.disableScreenProtection();
                    }
                  },
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.fingerprint, color: AppColors.primaryBlue),
                  title: const Text("Вход по Face ID / PIN", style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text("Запрашивать подтверждение при каждом открытии", style: TextStyle(fontSize: 12)),
                  value: _biometrics,
                  onChanged: (val) {
                    setState(() => _biometrics = val);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.vpn_key_outlined, color: AppColors.primaryBlue, size: 20),
                    SizedBox(width: 8),
                    Text("Ключи шифрования", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "ID сессии: ${StorageService().speaklyId}\nСквозное шифрование: AES-256-GCM + X25519",
                  style: const TextStyle(color: AppColors.textGray, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
