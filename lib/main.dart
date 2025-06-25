import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page_with_point.dart';
import 'pages/permission_request_page.dart';
import 'pages/admin_cert_page.dart';
import 'RepairPage/my_page.dart';
import 'RepairPage/gas_cert_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 웹을 위한 명시적 Firebase 초기화
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1qWzELPLvpXYohtN2IXIaMdzKgAr0h_M",
      authDomain: "drivener-wt31ga.firebaseapp.com",
      projectId: "drivener-wt31ga",
      storageBucket: "drivener-wt31ga.appspot.com",
      messagingSenderId: "148026973766",
      appId: "1:148026973766:web:5b786384eae526ae02c376",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveNER',
      debugShowCheckedModeBanner: false,
      initialRoute: '/permission',
      routes: {
        '/home': (context) => const HomePageWithPoint(),
        '/permission': (context) => const PermissionRequestPage(),
        '/mypage': (context) => const MyPage(),
        '/admin': (context) => const AdminCertPage(),
        '/gas': (context) => const GasCertPage(),
      },
    );
  }
}
