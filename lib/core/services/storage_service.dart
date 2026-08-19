import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Запись и чтение PIN
  Future<void> savePin(String pin) async =>
      await _secureStorage.write(key: 'user_pin', value: pin);

  Future<String?> getPin() async =>
      await _secureStorage.read(key: 'user_pin');

  // Данные пользователя
  Future<void> saveUserData({
    required String username,
    required String displayName,
    required String speaklyId,
  }) async {
    await _prefs.setString('username', username);
    await _prefs.setString('display_name', displayName);
    await _prefs.setString('speakly_id', speaklyId);
    await _prefs.setBool('is_registered', true);
  }

  String get username => _prefs.getString('username') ?? 'user';
  String get displayName => _prefs.getString('display_name') ?? 'Speakly User';
  String get speaklyId => _prefs.getString('speakly_id') ?? 'SPK-00000000';
  bool get isRegistered => _prefs.getBool('is_registered') ?? false;

  // Очки рейтинга
  int get ratingPoints => _prefs.getInt('rating_points') ?? 0;
  Future<void> addRatingPoints(int points) async {
    int current = ratingPoints;
    await _prefs.setInt('rating_points', current + points);
  }

  // Протокол Fenix (Полное уничтожение)
  Future<void> executeFenixProtocol() async {
    await _secureStorage.deleteAll();
    await _prefs.clear();
  }
}