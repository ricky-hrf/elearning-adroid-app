import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/core/themes/app_theme.dart';
import 'ui/dashboard/view_models/dashboard_view_model.dart';
import 'ui/auth/view_models/auth_view_model.dart';
import 'ui/auth/auth_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ElearningApp());
}

class ElearningApp extends StatelessWidget {
  const ElearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel()..initAuth(),
        ),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: MaterialApp(
        title: 'E-Learning',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(),
      ),
    );
  }
}