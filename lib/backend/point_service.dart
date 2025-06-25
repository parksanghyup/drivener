// lib/backend/point_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addPointsToUser({
  required String uid,
  required double pointsToAdd,
}) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  await FirebaseFirestore.instance.runTransaction((tx) async {
    final snapshot = await tx.get(userRef);
    final currentData = snapshot.data() ?? {};
    final currentTotal = (currentData['totalPoints'] ?? 0).toDouble();
    final driveCount = (currentData['driveCount'] ?? 0).toInt();

    tx.update(userRef, {
      'totalPoints': currentTotal + pointsToAdd,
      'lastDriveDate': DateTime.now(),
      'driveCount': driveCount + 1,
    });
  });
}
