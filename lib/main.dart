import 'package:flutter/material.dart';
// --- 1. Firebase Imports (Zaroori hain) ---
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ye file flutterfire configure se bani thi

// App start hone ke baad sabse pehle ye screen aayegi
import 'screens/splash_screen.dart';

// --- 2. Main Function ko 'async' banaya taake Firebase wait kar sake ---
void main() async {
  // Native code (Android/iOS) ko Flutter se baat karne ke liye ready karna
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase ko start karna (Generated options ke sath)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Jab connect ho jaye, tab App run karein
  runApp(const MyApp());
}

/// ============================================================
///  CLASS: MyApp
///  DESCRIPTION: Ye App ka Root hai. Yahan hum Global Theme,
///  Colors, aur Font set karte hain taake puri app consistent rahe.
/// ============================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // --- App Basic Config ---
      debugShowCheckedModeBanner: false, // Debug tag hataya
      title: 'WorkIn', // App ka naam

      // --- Global Theme (Design System) ---
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins', // Puri App ka default Font 'Poppins'

        // App ke Main Colors (Blue & Orange)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C43A8), // Main Blue
          primary: const Color(0xFF2C43A8),
          secondary: const Color(0xFFFF6B00), // Orange
          background: Colors.white,
        ),

        // Scaffold ka background color
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),

        // AppBar ki default styling
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),

      // --- Entry Point ---
      home: const SplashScreen(),
    );
  }
}