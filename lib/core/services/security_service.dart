import 'package:flutter/foundation.dart';

class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();

  bool _isGhostModeEnabled = false;
  bool _isScreenshotProtected = true;

  bool get isGhostMode => _isGhostModeEnabled;
  bool get isScreenshotProtected => _isScreenshotProtected;

  Future<void> enableScreenProtection() async {
    // В вебе защита экрана эмулируется программно
    _isScreenshotProtected = true;
  }

  Future<void> disableScreenProtection() async {
    _isScreenshotProtected = false;
  }

  void toggleGhostMode(bool value) {
    _isGhostModeEnabled = value;
  }

  Future<bool> authenticateWithBiometrics() async {
    // В вебе биометрия возвращает true
    return true;
  }
}
