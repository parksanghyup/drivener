
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RepairCertificationPage extends StatefulWidget {
  const RepairCertificationPage({super.key});

  @override
  State<RepairCertificationPage> createState() => _RepairCertificationPageState();
}

class _RepairCertificationPageState extends State<RepairCertificationPage> {
  String? selectedItem;
  final TextEditingController priceController = TextEditingController();
  File? _imageFile;

  final List<String> repairItems = [
    '엔진오일', '에어컨 필터', '타이어 교체', '브레이크 패드', '냉각수',
  ];

  final Map<String, int> averagePrices = {
    '엔진오일': 60000,
    '에어컨 필터': 20000,
    '타이어 교체': 120000,
    '브레이크 패드': 80000,
    '냉각수': 40000,
  };

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  String evaluatePrice() {
    if (selectedItem == null || priceController.text.isEmpty) return '';
    final inputPrice = int.tryParse(priceController.text) ?? 0;
    final avgPrice = averagePrices[selectedItem] ?? 0;

    if (inputPrice < avgPrice * 0.7) return '저렴';
    if (inputPrice > avgPrice * 1.3) return '과다';
    return '적정';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('정비소 인증')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('정비 항목 선택:'),
            DropdownButton<String>(
              value: selectedItem,
              hint: const Text('항목 선택'),
              isExpanded: true,
              items: repairItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
            ),
            const SizedBox(height: 12),
            const Text('금액 입력 (원):'),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '예: 50000'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('사진 첨부'),
            ),
            const SizedBox(height: 8),
            if (_imageFile != null)
              Image.file(_imageFile!, height: 150),
            const SizedBox(height: 16),
            if (evaluatePrice().isNotEmpty)
              Text('평가 결과: ${evaluatePrice()}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // TODO: Firestore 저장 및 포인트 지급 처리 연결
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('인증 완료! 포인트가 지급되었습니다.')),
                );
              },
              child: const Text('인증 제출 및 포인트 지급'),
            ),
          ],
        ),
      ),
    );
  }
}
