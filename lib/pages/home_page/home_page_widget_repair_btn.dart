import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageWidget extends StatefulWidget {
  const MyPageWidget({Key? key}) : super(key: key);

  @override
  State<MyPageWidget> createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  String uid = '';
  int pointTotal = 0;
  double totalDistance = 0.0;
  List<Map<String, dynamic>> maintenanceHistory = [];
  List<Map<String, dynamic>> refuelHistory = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    setState(() => uid = user.uid);

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final maintenanceDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('maintenance')
        .orderBy('date', descending: true)
        .get();

    final refuelDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('refuel')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      pointTotal = userDoc.data()?['pointTotal'] ?? 0;
      totalDistance = (userDoc.data()?['totalDistance'] ?? 0).toDouble();
      maintenanceHistory = maintenanceDocs.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      refuelHistory = refuelDocs.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👤 마이페이지')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('UID: $uid', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Text('🏅 누적 포인트: $pointTotal P', style: TextStyle(fontSize: 18)),
            Text('🛣️ 총 주행 거리: ${totalDistance.toStringAsFixed(2)} km', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 30),
            Text('🧰 정비소 인증 내역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...maintenanceHistory.map((entry) => ListTile(
                  title: Text(entry['type'] ?? '정비 항목 없음'),
                  subtitle: Text('날짜: ${entry['date']?.toDate()?.toString().split(' ')[0] ?? '-'}'),
                  trailing: Text('${entry['point'] ?? 0} P'),
                )),

            const SizedBox(height: 30),
            Text('⛽ 주유소 인증 내역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...refuelHistory.map((entry) => ListTile(
                  title: Text(entry['location'] ?? '주유소'),
                  subtitle: Text('날짜: ${entry['date']?.toDate()?.toString().split(' ')[0] ?? '-'}'),
                  trailing: Text('${entry['point'] ?? 0} P'),
                )),
          ],
        ),
      ),
    );
  }
}
