import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/auth_state.dart';
import 'view_models/auth_view_model.dart';
import '../core/widgets/app_text_field.dart';
import '../core/widgets/app_checkbox.dart';
import '../core/widgets/brand_header_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthViewModel>().login(
        _emailController.text,
        _passwordController.text,
        rememberMe: _rememberMe,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const BrandHeaderCard(
                  platformName: 'E-LEARNING',
                  schoolName: 'SMA UNGGUL BINA KASIH NUSANTARA',
                  logoAsset: 'assets/img/logo.png',
                ),
                const SizedBox(height: 16),
                const Text('Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3C86F6)
                  ),
                ),
                const SizedBox(height: 16),
                if (authVM.errorMessage != null)
                  Text(
                    authVM.errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _emailController,
                  hint: 'example@student.ubkn.sch.id',
                  label: 'Username',
                  prefixIcon: Icons.person,
                  textInputAction: TextInputAction.next,
                  validator: (val) => val!.isEmpty ? 'Username wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleLogin(),
                  validator: (val) => val!.isEmpty ? 'Password wajib diisi' : null,
                ),
                const SizedBox(height: 8),
                AppCheckbox(
                  value: _rememberMe,
                  onChanged: (v) => setState(() => _rememberMe = v),
                  label: 'Remember Me!',
                ),
                const SizedBox(height:8),
                ElevatedButton(
                  onPressed: authVM.state == AuthState.authenticating
                      ? null
                      : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF3C86F6),
                  ),
                  child: authVM.state == AuthState.authenticating
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                      : const Text('Login', style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}