import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:screen_protector/screen_protector.dart';

class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> enableScreenProtection() async {
    if (!kIsWeb) {
      await ScreenProtector.preventScreenshotOn();
    }
  }

  Future<void> disableScreenProtection() async {
    if (!kIsWeb) {
      await ScreenProtector.preventScreenshotOff();
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    if (kIsWeb) return true;
    try {
      final bool canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
      if (!canAuthenticate) return true;

      return await _localAuth.authenticate(
        localizedReason: 'Подтвердите вход в Speakly',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}