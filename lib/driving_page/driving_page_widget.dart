import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DrivingPageWidget extends StatefulWidget {
  const DrivingPageWidget({Key? key}) : super(key: key);

  @override
  _DrivingPageWidgetState createState() => _DrivingPageWidgetState();
}

class _DrivingPageWidgetState extends State<DrivingPageWidget> {
  DateTime? _startTime;
  GeoPoint? _startLocation;
  bool isDriving = false;

  // TODO: Firebase Auth 연동 시 자동 설정. 현재는 테스트용 유저 ID 사용
  String currentUserUid = 'test_user_001';

  /// 주행 시작
  Future<void> _startDriving() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      isDriving = true;
      _startTime = DateTime.now();
      _startLocation = GeoPoint(position.latitude, position.longitude);
    });
  }

  /// 주행 종료
  Future<void> _endDriving() async {
    if (!isDriving || _startTime == null || _startLocation == null) return;

    final endTime = DateTime.now();
    final position = await Geolocator.getCurrentPosition();
    final endLocation = GeoPoint(position.latitude, position.longitude);

    final distance = calculateDistance(
      _startLocation!.latitude,
      _startLocation!.longitude,
      endLocation.latitude,
      endLocation.longitude,
    );

    final earnedPoints = (distance * 10).toInt();

    await saveDriveSession(
      userRef: FirebaseFirestore.instance.doc('users/$currentUserUid'),
      startTime: _startTime!,
      endTime: endTime,
      distance: distance,
      earnedPoints: earnedPoints,
      startLocation: _startLocation!,
      endLocation: endLocation,
    );

    setState(() {
      isDriving = false;
      _startTime = null;
      _startLocation = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('주행 종료! $earnedPoints 포인트 적립')),
    );
  }

  /// 거리 계산 함수 (Haversine)
  double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // km
    final double dLat = _degToRad(lat2 - lat1);
    final double dLon = _degToRad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double degree) {
    return degree * pi / 180;
  }

  /// Firestore에 주행 기록 저장 + 유저 포인트 누적
  Future<void> saveDriveSession({
    required DocumentReference userRef,
    required DateTime startTime,
    required DateTime endTime,
    required double distance,
    required int earnedPoints,
    required GeoPoint startLocation,
    required GeoPoint endLocation,
  }) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('drive_sessions').add({
      'user_id': userRef,
      'start_time': Timestamp.fromDate(startTime),
      'end_time': Timestamp.fromDate(endTime),
      'distance': distance,
      'points': earnedPoints,
      'start_location': startLocation,
      'end_location': endLocation,
      'created_at': FieldValue.serverTimestamp(),
    });

    // 유저 포인트 누적 업데이트
    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      final currentPoints = (snapshot['points'] ?? 0) as int;
      transaction.update(userRef, {
        'points': currentPoints + earnedPoints,
        'total_distance': (snapshot['total_distance'] ?? 0) + distance,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('주행 기록')),
      body: Center(
        child: isDriving
            ? ElevatedButton(
                onPressed: _endDriving,
                child: const Text('주행 종료'),
              )
            : ElevatedButton(
                onPressed: _startDriving,
                child: const Text('주행 시작'),
              ),
      ),
    );
  }
}
