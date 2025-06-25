import 'package:flutter/material.dart';

class MPage extends StatelessWidget {
  const MPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("마이페이지")),
      body: const Center(child: Text("여기에 마이페이지 내용")),
    );
  }
}
