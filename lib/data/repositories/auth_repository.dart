import '../../domain/models/user.dart';
import '../services/api_client.dart';
import '../services/token_storage.dart';

class AuthRepository {
  final _api = ApiClient.instance;
  final _tokens = TokenStorage.instance;

  Future<User> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final res = await _api.post('/auth/login', auth: false, body: {
      'email': email,
      'password': password,
      'remember_me': rememberMe,
    });
    final data = res['data'] as Map<String, dynamic>;
    await _tokens.save(data['token'] as String, persist: rememberMe);
    return User.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<bool> hasToken() async => (await _tokens.read()) != null;

  Future<User> me() async {
    final res = await _api.get('/auth/me');
    final data = res['data'] as Map<String, dynamic>;
    return User.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<void> logout() => _tokens.clear();
}