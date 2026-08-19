import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../privacy/screens/privacy_settings_screen.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StorageService _storage = StorageService();

  void _executeFenix() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Протокол Fenix"),
        content: const Text("Все ваши чаты, сообщения и аккаунт будут безвозвратно стёрты с сервера и устройства."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _storage.executeFenixProtocol();
              if (!mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                (route) => false,
              );
            },
            child: const Text("Стереть всё", style: TextStyle(color: AppColors.dangerRed)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final points = _storage.ratingPoints;
    final username = _storage.username;
    final speaklyId = _storage.speaklyId;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Stack(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 50, color: AppColors.primaryBlue),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.dangerRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.priority_high, size: 12, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(username, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("@$username", style: const TextStyle(color: AppColors.textGray, fontSize: 13)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                speaklyId,
                style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
            const SizedBox(height: 20),
            // Блок рейтинга
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 6),
                          Text("Рейтинг", style: TextStyle(color: AppColors.textGray)),
                        ],
                      ),
                      const Text("Уровень", style: TextStyle(color: AppColors.textGray)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$points очков", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text("1", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: points / 5000,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 6),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("До 2 уровня: 5000 очков", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(Icons.palette_outlined, "Внешний вид", trailing: "Светлая >"),
            _buildMenuItem(Icons.language_outlined, "Язык", trailing: "RU >"),
            _buildMenuItem(
              Icons.shield_outlined,
              "Конфиденциальность",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PrivacySettingsScreen()),
                );
              },
            ),
            _buildMenuItem(Icons.admin_panel_settings_outlined, "Админ-панель", badge: "ADMIN"),
            _buildMenuItem(Icons.people_outline, "Сменить аккаунт"),
            _buildMenuItem(
              Icons.local_fire_department_outlined,
              "Протокол Fenix",
              subtitle: "Удалить все данные",
              iconColor: AppColors.dangerRed,
              textColor: AppColors.dangerRed,
              onTap: _executeFenix,
            ),
            _buildMenuItem(
              Icons.logout,
              "Выйти",
              iconColor: AppColors.dangerRed,
              textColor: AppColors.dangerRed,
              onTap: _executeFenix,
            ),
            const SizedBox(height: 16),
            const Text("Speakly v1.0.0", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? trailing,
    String? subtitle,
    String? badge,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? AppColors.primaryBlue),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.textDark,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ]
          ],
        ),
        subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: textColor ?? AppColors.textGray, fontSize: 12)) : null,
        trailing: trailing != null ? Text(trailing, style: const TextStyle(color: AppColors.textGray)) : const Icon(Icons.chevron_right, color: AppColors.textGray),
      ),
    );
  }
}