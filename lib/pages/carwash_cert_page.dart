import 'package:flutter/material.dart';

class CarWashCertPage extends StatelessWidget {
  const CarWashCertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("세차장 인증")),
      body: const Center(child: Text("세차장 인증 페이지입니다")),
    );
  }
}
