import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String _keyToken = 'auth_token';
  static const String _keyExpiry = 'auth_token_expiry';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@ubkn.sch.id' && password == '12345') {
      final prefs = await _prefs;

      final token = 'mock_token_xyz_123';

      final expiryTime = DateTime.now()
          .add(const Duration(minutes: 15))
          .millisecondsSinceEpoch;

      await prefs.setString(_keyToken, token);
      await prefs.setInt(_keyExpiry, expiryTime);

      return true;
    }
    return false;
  }

  Future<bool> checkAuthStatus() async {
    final prefs = await _prefs;
    final token = prefs.getString(_keyToken);
    final expiry = prefs.getInt(_keyExpiry);

    if (token == null || expiry == null) {
      return false;
    }

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime > expiry) {
      await logout();
      return false;
    }

    return true;
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_keyToken);
    await prefs.remove(_keyExpiry);
  }
}