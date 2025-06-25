import 'package:flutter/material.dart';
import 'base_auth_user_provider.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return loggedIn
        ? const HomePage()
        : const LoginPage(); // 추후 LoginPage 구현 필요
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('로그인 성공, 홈화면입니다!')),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('로그인 화면 (추후 구현)')),
    );
  }
}
