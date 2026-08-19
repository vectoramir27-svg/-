import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Данные пользователя
  String get username => _prefs?.getString('username') ?? 'user';
  String get displayName => _prefs?.getString('displayName') ?? 'User';
  String get speaklyId => _prefs?.getString('speaklyId') ?? 'SPK-00000000';
  bool get isRegistered => _prefs?.getBool('isRegistered') ?? false;
  int get ratingPoints => _prefs?.getInt('ratingPoints') ?? 1250;

  Future<void> saveUserData({
    required String username,
    required String displayName,
    required String speaklyId,
  }) async {
    await _prefs?.setString('username', username);
    await _prefs?.setString('displayName', displayName);
    await _prefs?.setString('speaklyId', speaklyId);
    await _prefs?.setBool('isRegistered', true);
  }

  // Добавление очков рейтинга
  Future<void> addRatingPoints(int points) async {
    final current = ratingPoints;
    await _prefs?.setInt('ratingPoints', current + points);
  }

  // Сохранение и получение PIN-кода
  Future<void> savePin(String pin) async {
    await _prefs?.setString('user_pin', pin);
  }

  Future<String?> getPin() async {
    return _prefs?.getString('user_pin');
  }

  // Протокол Fenix: полное безвозвратное стирание всех данных
  Future<void> executeFenixProtocol() async {
    await _prefs?.clear();
  }

  // Очистка сессии
  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
