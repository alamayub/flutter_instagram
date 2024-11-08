import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RootScreen(),
    );
  }
}

/*
 
Alias name: androiddebugkey
Creation date: 1 Nov 2024
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Fri Nov 01 23:52:59 IST 2024 until: Sun Oct 25 23:52:59 IST 2054
Certificate fingerprints:
         SHA1: DE:DE:22:06:21:FE:FB:3A:BB:5C:1A:8C:3D:04:B9:B2:E6:C9:78:28
         SHA256: 5F:08:C9:02:EF:5E:68:AD:9A:20:1C:5C:A5:20:18:18:82:47:E8:4F:37:11:4B:1D:DF:25:54:6A:5A:F0:E7:EE
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1
*/