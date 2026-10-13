import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/auth_state.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  AuthState _state = AuthState.unauthenticated;
  String? _errorMessage;

  AuthState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> initAuth() async {
    _state = AuthState.authenticating;
    notifyListeners();

    final isValid = await _repository.checkAuthStatus();

    if (isValid) {
      _state = AuthState.authenticated;
    } else {
      _state = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _errorMessage = null;
    _state = AuthState.authenticating;
    notifyListeners();

    try {
      final success = await _repository.login(email, password);

      if (success) {
        _state = AuthState.authenticated;
      } else {
        _state = AuthState.unauthenticated;
        _errorMessage = 'Email atau password salah!';
      }
    } catch (e) {
      _state = AuthState.unauthenticated;
      _errorMessage = 'Terjadi kesalahan: $e';
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _repository.logout();
    _state = AuthState.unauthenticated;
    notifyListeners();
  }
}