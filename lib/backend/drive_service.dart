// lib/backend/drive_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveDriveSession({
  required String uid,
  required DateTime startTime,
  required DateTime endTime,
  required double distanceKm,
  required double pointsEarned,
}) async {
  final sessionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('driveSessions')
      .doc(); // 자동 생성 ID

  await sessionRef.set({
    'start_time': startTime,
    'end_time': endTime,
    'distance_km': distanceKm,
    'points_earned': pointsEarned,
    'created_time': Timestamp.now(),
  });

  print("✅ 주행 기록 저장 완료");
}
