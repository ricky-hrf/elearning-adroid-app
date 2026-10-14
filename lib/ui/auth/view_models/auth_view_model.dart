import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/auth_state.dart';

class AuthViewModel extends ChangeNotifier {
  static const _rememberKey = 'remember_me';
  bool _isInitializing = true;
  bool get isInitializing => _isInitializing;
  final AuthRepository _repository = AuthRepository();

  AuthState _state = AuthState.unauthenticated;
  String? _errorMessage;

  AuthState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> initAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool(_rememberKey) ?? false;

    bool isValid = false;
    if (remember) {
      isValid = await _repository.checkAuthStatus();
    } else {
      try {
        await _repository.logout();
      } catch (_) {}
    }

    _state = isValid ? AuthState.authenticated : AuthState.unauthenticated;
    _isInitializing = false;
    notifyListeners();
  }

  Future<void> login(String email, String password,
      {bool rememberMe = false}) async {
    _errorMessage = null;
    _state = AuthState.authenticating;
    notifyListeners();

    try {
      final success = await _repository.login(email, password);

      if (success) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_rememberKey, rememberMe);
        _state = AuthState.authenticated;
      } else {
        _state = AuthState.unauthenticated;
        _errorMessage = 'username / password salah!';
      }
    } catch (e) {
      _state = AuthState.unauthenticated;
      _errorMessage = 'Terjadi kesalahan: $e';
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _repository.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberKey, false);
    _state = AuthState.unauthenticated;
    notifyListeners();
  }
}