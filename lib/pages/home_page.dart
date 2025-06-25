import 'package:flutter/material.dart';
import 'repair_cert_page.dart';
import 'fuel_cert_page.dart';
import 'carwash_cert_page.dart'; // 🚿 세차장 인증 페이지도 예정
import 'mypage.dart';
import 'admin_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DriveNER 홈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ✅ 정비소 인증
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RepairCertPage()),
                );
              },
              child: const Text('정비소 인증'),
            ),

            const SizedBox(height: 12),

            // ✅ 주유소 인증
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FuelCertPage()),
                );
              },
              child: const Text('주유소 인증'),
            ),

            const SizedBox(height: 12),

            // ✅ 세차장 인증
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CarWashCertPage()),
                );
              },
              child: const Text('세차장 인증'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPage()),
                );
              },
              child: const Text('마이페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                );
              },
              child: const Text('관리자 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UIDRegisterPage()),
                );
              },
              child: const Text('UID 등록'),
            ),
          ],
        ),
      ),
    );
  }
}
