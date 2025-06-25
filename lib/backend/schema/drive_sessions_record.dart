import 'package:cloud_firestore/cloud_firestore.dart';

class DriveSessionRecord {
  final DocumentReference uid;          // 유저 참조
  final DateTime startTime;             // 주행 시작 시간
  final DateTime endTime;               // 주행 종료 시간
  final double distance;                // 주행 거리 (km)
  final int earnedPoints;               // 적립된 포인트
  final GeoPoint startLocation;         // 시작 위치
  final GeoPoint endLocation;           // 종료 위치
  final DateTime createdAt;             // 생성 시각
  final String sessionId;               // 세션 ID

  DriveSessionRecord({
    required this.uid,
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.earnedPoints,
    required this.startLocation,
    required this.endLocation,
    required this.createdAt,
    required this.sessionId,
  });

  // Firestore에 저장할 Map 구조로 변환
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'distance': distance,
      'earnedPoints': earnedPoints,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'createdAt': Timestamp.fromDate(createdAt),
      'sessionId': sessionId,
    };
  }

  // Firestore에서 데이터를 불러올 때 사용하는 factory 생성자
  factory DriveSessionRecord.fromMap(Map<String, dynamic> map) {
    return DriveSessionRecord(
      uid: map['uid'] as DocumentReference,
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
      distance: (map['distance'] as num).toDouble(),
      earnedPoints: map['earnedPoints'] ?? 0,
      startLocation: map['startLocation'] as GeoPoint,
      endLocation: map['endLocation'] as GeoPoint,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      sessionId: map['sessionId'] ?? '',
    );
  }

  // Firestore 문서 스냅샷에서 직접 생성
  factory DriveSessionRecord.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DriveSessionRecord.fromMap(data);
  }
}
