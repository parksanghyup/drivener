import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'driving_page_widget.dart' show DrivingPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrivingPageModel extends FlutterFlowModel<DrivingPageWidget> {
  bool isDriving = false;
  LatLng? startLocation;
  LatLng? endLocation;
  DateTime? startTime;
  DateTime? endTime;
  double totalDistance = 0.0;

  @override
  void initState(BuildContext context) {
    isDriving = false;
  }

  void startDriving(LatLng location) {
    isDriving = true;
    startLocation = location;
    startTime = DateTime.now();
    totalDistance = 0.0;
  }

  void stopDriving(LatLng location) {
    isDriving = false;
    endLocation = location;
    endTime = DateTime.now();
  }

  void addDistance(double meters) {
    totalDistance += meters;
  }

  Duration getDriveDuration() {
    if (startTime != null && endTime != null) {
      return endTime!.difference(startTime!);
    }
    return Duration.zero;
  }

  @override
  void dispose() {
    // Clean-up if needed
  }
}
