import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipora/pages/splash_screen.dart';
import 'firebase_options.dart';
import 'pages/main_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ReciporaApp());
}

class ReciporaApp extends StatelessWidget {
  const ReciporaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipora',
      home: const SplashScreen(),
    );
  }
}