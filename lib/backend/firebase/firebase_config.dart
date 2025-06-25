import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAGZ1ANY3ELPEuPXyoT2yNb2INIaDX4R6M",
            authDomain: "drivener-wt31ga.firebaseapp.com",
            projectId: "drivener-wt31ga",
            storageBucket: "drivener-wt31ga.firebasestorage.app",
            messagingSenderId: "480269377105",
            appId: "1:480269377105:web:0ac2e6a0259d101b3c6270"));
  } else {
    await Firebase.initializeApp();
  }
}
