import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FuelCertPage extends StatefulWidget {
  const FuelCertPage({super.key});

  @override
  State<FuelCertPage> createState() => _FuelCertPageState();
}

class _FuelCertPageState extends State<FuelCertPage> {
  final TextEditingController amountController = TextEditingController();
  File? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> submitFuelCert() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || amountController.text.isEmpty || image == null) return;

    await FirebaseFirestore.instance.collection('fuel_certifications').add({
      'uid': uid,
      'amount': amountController.text,
      'timestamp': Timestamp.now(),
      'image_path': image!.path,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('주유 인증 완료!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('주유소 인증')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 주유 금액 입력
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '주유 금액 (원)',
              ),
            ),

            const SizedBox(height: 12),

            // 영수증 사진 업로드
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('영수증 업로드'),
            ),
            if (image != null) Image.file(image!, height: 150),

            const SizedBox(height: 20),

            // 제출
            ElevatedButton(
              onPressed: submitFuelCert,
              child: const Text('인증 제출'),
            ),
          ],
        ),
      ),
    );
  }
}
