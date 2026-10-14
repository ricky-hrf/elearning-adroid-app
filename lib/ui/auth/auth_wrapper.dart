import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/auth_view_model.dart';
import '../dashboard/dashboard_page.dart';
import 'login_page.dart';
import '../../domain/models/auth_state.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    if (authVM.isInitializing) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (authVM.state == AuthState.authenticated) {
      return const DashboardPage();
    }

    return const LoginPage();
  }
}