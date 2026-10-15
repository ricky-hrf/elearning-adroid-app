import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/api_client.dart';
import '../../../domain/models/auth_state.dart';
import '../../../domain/models/user.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    ApiClient.instance.onUnauthorized = _handleSessionExpired;
  }

  final AuthRepository _repository = AuthRepository();

  bool _isInitializing = true;
  AuthState _state = AuthState.unauthenticated;
  String? _errorMessage;
  User? _user;

  bool get isInitializing => _isInitializing;
  AuthState get state => _state;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  Future<void> initAuth() async {
    try {
      if (await _repository.hasToken()) {
        _user = await _repository.me();
        _state = AuthState.authenticated;
      }
    } catch (_) {
      _user = null;
      _state = AuthState.unauthenticated;
    }
    _isInitializing = false;
    notifyListeners();
  }

  Future<void> login(String email, String password,
      {bool rememberMe = false}) async {
    _errorMessage = null;
    _state = AuthState.authenticating;
    notifyListeners();

    try {
      _user = await _repository.login(
        email: email.trim(),
        password: password,
        rememberMe: rememberMe,
      );
      _state = AuthState.authenticated;
    } on ApiException catch (e) {
      _state = AuthState.unauthenticated;
      _errorMessage = e.message;
    } catch (_) {
      _state = AuthState.unauthenticated;
      _errorMessage = 'Terjadi kesalahan, coba lagi';
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    _errorMessage = null;
    _state = AuthState.unauthenticated;
    notifyListeners();
  }

  void _handleSessionExpired() {
    _user = null;
    _state = AuthState.unauthenticated;
    _errorMessage = 'Sesi berakhir, silakan login kembali';
    notifyListeners();
  }

  @override
  void dispose() {
    ApiClient.instance.onUnauthorized = null;
    super.dispose();
  }
}