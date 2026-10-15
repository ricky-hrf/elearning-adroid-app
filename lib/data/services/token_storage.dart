import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();
  static final TokenStorage instance = TokenStorage._();

  static const _key = 'auth_token';
  final _secure = const FlutterSecureStorage();
  String? _memoryToken;

  Future<void> save(String token, {required bool persist}) async {
    _memoryToken = token;
    if (persist) {
      await _secure.write(key: _key, value: token);
    } else {
      await _secure.delete(key: _key);
    }
  }

  Future<String?> read() async {
    _memoryToken ??= await _secure.read(key: _key);
    return _memoryToken;
  }

  Future<void> clear() async {
    _memoryToken = null;
    await _secure.delete(key: _key);
  }
}