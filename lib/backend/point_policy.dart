// lib/backend/point_policy.dart

class PointPolicy {
  static const double perKm = 2.0;              // 1km당 포인트
  static const double firstDriveBonus = 1.5;    // 첫 주행 보너스 배율
  static const double dailyMax = 100.0;         // 일일 최대 포인트
  static const double checkInReward = 20.0;     // 정비소/주유소 인증 보상
}
