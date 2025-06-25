import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/location_service.dart';
import 'package:intl/intl.dart';

class DrivingPage extends StatefulWidget {
  const DrivingPage({Key? key}) : super(key: key);

  @override
  State<DrivingPage> createState() => _DrivingPageState();
}

class _DrivingPageState extends State<DrivingPage> {
  bool isDriving = false;
  double? distance;
  double? startLat;
  double? startLng;

  void startDriving() async {
    final location = await getCurrentLocation();
    setState(() {
      isDriving = true;
      startLat = location.latitude;
      startLng = location.longitude;
    });
  }

  void endDriving() async {
    final location = await getCurrentLocation();
    final endLat = location.latitude;
    final endLng = location.longitude;
    distance = calculateDistance(startLat!, startLng!, endLat, endLng);

    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('drive_sessions').add({
      'userId': user!.uid,
      'distance': distance,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      isDriving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('주행 종료: ${distance!.toStringAsFixed(2)}km')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DriveNER 주행')),
      body: Center(
        child: isDriving
            ? ElevatedButton(onPressed: endDriving, child: Text('주행 종료'))
            : ElevatedButton(onPressed: startDriving, child: Text('주행 시작')),
      ),
    );
  }
}
