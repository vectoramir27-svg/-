import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/app_state.dart';
import '../../privacy/screens/privacy_settings_screen.dart';
import '../../admin/screens/admin_panel_screen.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../../auth/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StorageService _storage = StorageService();
  final AppState _appState = AppState();

  void _chooseAvatar() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Выберите аватар профиля", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["🚀", "🕶️", "⚡", "🦊", "👑"].map((emoji) {
                return InkWell(
                  onTap: () {
                    _appState.setAvatar(emoji);
                    Navigator.pop(ctx);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor),
                    child: Text(emoji, style: const TextStyle(fontSize: 30)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _safeLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Выход из аккаунта"),
        content: const Text("Вы сможете войти обратно, используя ваш @username / SpeaklyID и PIN-код."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("Выйти", style: TextStyle(color: AppColors.primaryBlue)),
          ),
        ],
      ),
    );
  }

  void _executeFenix() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("🔥 Протокол Fenix"),
        content: const Text("Внимание! Все чаты, ключи шифрования и профиль будут БЕЗВОЗВРАТНО уничтожены."),
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
    final isAdmin = _appState.isAdmin;

    return Scaffold(
      appBar: AppBar(title: Text(_appState.tr('profile'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _chooseAvatar,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.blue.shade100,
                    child: _appState.customAvatarUrl != null
                        ? Text(_appState.customAvatarUrl!, style: const TextStyle(fontSize: 40))
                        : const Icon(Icons.person, size: 50, color: AppColors.primaryBlue),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(username, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("@$username", style: const TextStyle(color: AppColors.textGray, fontSize: 13)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
              child: Text(speaklyId, style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
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
                      Text("Уровень ${points >= 5000 ? 2 : 1}", style: const TextStyle(color: AppColors.textGray)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$points очков", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("${points >= 5000 ? 2 : 1}", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (points / 5000).clamp(0.0, 1.0),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      points >= 5000 ? "Максимальный уровень разблокирован!" : "До 2 уровня: ${5000 - points} очков",
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              Icons.palette_outlined,
              _appState.tr('appearance'),
              trailing: _appState.isDarkMode ? "Тёмная >" : "Светлая >",
              onTap: () => setState(() => _appState.toggleTheme()),
            ),
            _buildMenuItem(
              Icons.language_outlined,
              _appState.tr('language'),
              trailing: "${_appState.currentLocale} >",
              onTap: () => setState(() => _appState.toggleLocale()),
            ),
            _buildMenuItem(
              Icons.shield_outlined,
              _appState.tr('privacy'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrivacySettingsScreen())),
            ),
            if (isAdmin)
              _buildMenuItem(
                Icons.admin_panel_settings_outlined,
                _appState.tr('admin_panel'),
                badge: "ADMIN",
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminPanelScreen())),
              ),
            _buildMenuItem(Icons.people_outline, _appState.tr('switch_account'), onTap: _safeLogout),
            _buildMenuItem(
              Icons.local_fire_department_outlined,
              _appState.tr('fenix_proto'),
              subtitle: "Удалить все данные",
              iconColor: AppColors.dangerRed,
              textColor: AppColors.dangerRed,
              onTap: _executeFenix,
            ),
            _buildMenuItem(
              Icons.logout,
              _appState.tr('logout'),
              iconColor: AppColors.primaryBlue,
              textColor: AppColors.primaryBlue,
              onTap: _safeLogout,
            ),
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
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? AppColors.primaryBlue),
        title: Row(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: textColor)),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(6)),
                child: Text(badge, style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
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
