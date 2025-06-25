// lib/pages/home_page_with_point.dart

import 'package:flutter/material.dart';
import 'mypage.dart';
import 'carwash_cert_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'repair_cert_page.dart';
import 'fuel_cert_page.dart';
import 'admin_page.dart';

class HomePageWithPoint extends StatefulWidget {
  const HomePageWithPoint({super.key});

  @override
  State<HomePageWithPoint> createState() => _HomePageWithPointState();
}

class _HomePageWithPointState extends State<HomePageWithPoint> {
  String userId = '';
  int userPoint = 0;

  @override
  void initState() {
    super.initState();
    checkAndGiveWelcomePoint();
  }

  Future<void> checkAndGiveWelcomePoint() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      await userDoc.set({
        'point': 100,
        'welcomePointGiven': true,
        'joinedAt': FieldValue.serverTimestamp(),
      });
      await FirebaseFirestore.instance.collection('pointHistory').add({
        'uid': uid,
        'type': '가입',
        'point': 100,
        'date': FieldValue.serverTimestamp(),
      });
      setState(() {
        userId = uid;
        userPoint = 100;
      });
    } else {
      final data = snapshot.data()!;
      final alreadyGiven = data['welcomePointGiven'] ?? false;
      final currentPoint = data['point'] ?? 0;

      if (!alreadyGiven) {
        await userDoc.update({
          'point': FieldValue.increment(100),
          'welcomePointGiven': true,
        });
        await FirebaseFirestore.instance.collection('pointHistory').add({
          'uid': uid,
          'type': '가입보너스',
          'point': 100,
          'date': FieldValue.serverTimestamp(),
        });
        setState(() {
          userId = uid;
          userPoint = currentPoint + 100;
        });
      } else {
        setState(() {
          userId = uid;
          userPoint = currentPoint;
        });
      }
    }
  }

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
            Text('UID: $userId'),
            Text('보유 포인트: $userPoint P'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RepairCertPage()));
              },
              child: const Text('정비소 인증'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FuelCertPage()));
              },
              child: const Text('주유소 인증'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CarWashCertPage()));
              },
              child: const Text('세차장 인증'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MPage()));
              },
              child: const Text('마이페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminPage()));
              },
              child: const Text('관리자 페이지'),
            ),
          ],
        ),
      ),
    );
  }
}
