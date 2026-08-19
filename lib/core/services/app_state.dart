import 'package:flutter/material.dart';
import 'storage_service.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  bool _isDarkMode = false;
  String _currentLocale = 'RU';
  bool _isSupportRead = false;
  String? _customAvatarUrl;

  bool get isDarkMode => _isDarkMode;
  String get currentLocale => _currentLocale;
  bool get isSupportRead => _isSupportRead;
  String? get customAvatarUrl => _customAvatarUrl;

  bool get isAdmin =>
      StorageService().username.toLowerCase() == 'admin' ||
      StorageService().username.toLowerCase() == 'creator';

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool dark) {
    _isDarkMode = dark;
    notifyListeners();
  }

  void setLocale(String lang) {
    _currentLocale = lang;
    notifyListeners();
  }

  void toggleLocale() {
    _currentLocale = _currentLocale == 'RU' ? 'EN' : 'RU';
    notifyListeners();
  }

  void markSupportAsRead() {
    _isSupportRead = true;
    notifyListeners();
  }

  void setAvatar(String avatar) {
    _customAvatarUrl = avatar;
    notifyListeners();
  }

  // Переводы
  String tr(String key) {
    final Map<String, Map<String, String>> localized = {
      'welcome_title': {
        'RU': 'Добро пожаловать\nв Speakly',
        'EN': 'Welcome to\nSpeakly',
      },
      'welcome_desc': {
        'RU': 'Мессенджер нового поколения\nс максимальной конфиденциальностью',
        'EN': 'Next-gen messenger\nwith absolute privacy',
      },
      'chats': {'RU': 'Чаты', 'EN': 'Chats'},
      'calls': {'RU': 'Вызовы', 'EN': 'Calls'},
      'profile': {'RU': 'Профиль', 'EN': 'Profile'},
      'privacy': {'RU': 'Конфиденциальность', 'EN': 'Privacy'},
      'appearance': {'RU': 'Внешний вид', 'EN': 'Appearance'},
      'language': {'RU': 'Язык', 'EN': 'Language'},
      'switch_account': {'RU': 'Сменить аккаунт', 'EN': 'Switch Account'},
      'fenix_proto': {'RU': 'Протокол Fenix', 'EN': 'Fenix Protocol'},
      'logout': {'RU': 'Выйти', 'EN': 'Log Out'},
      'admin_panel': {'RU': 'Админ-панель', 'EN': 'Admin Panel'},
      'next': {'RU': 'Далее', 'EN': 'Next'},
      'skip': {'RU': 'Пропустить', 'EN': 'Skip'},
      'start': {'RU': 'Начать', 'EN': 'Get Started'},
      'login_btn': {'RU': 'Войти в аккаунт', 'EN': 'Log In'},
      'no_calls': {'RU': 'Нет вызовов', 'EN': 'No calls yet'},
      'no_calls_desc': {'RU': 'Здесь будет история ваших звонков', 'EN': 'Your call logs will appear here'},
    };

    if (localized.containsKey(key)) {
      return localized[key]?[_currentLocale] ?? key;
    }
    return key;
  }
}
