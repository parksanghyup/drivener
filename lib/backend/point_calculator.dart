// lib/backend/point_calculator.dart

import 'package:drivener/backend/point_policy.dart';

double calculateDrivingPoints(double distanceKm, {bool isFirstDrive = false}) {
  double basePoints = distanceKm * PointPolicy.perKm;
  if (isFirstDrive) {
    basePoints *= PointPolicy.firstDriveBonus;
  }
  return basePoints.clamp(0, PointPolicy.dailyMax);
}
