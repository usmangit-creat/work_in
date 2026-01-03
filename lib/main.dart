import 'package:flutter/material.dart';
// App start hone ke baad sabse pehle ye screen aayegi
import 'screens/splash_screen.dart';

void main() {
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
      // --- 1. App Basic Config ---
      debugShowCheckedModeBanner: false, // Debug tag hataya
      title: 'WorkIn', // App ka naam

      // --- 2. Global Theme (Design System) ---
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins', // Puri App ka default Font 'Poppins' kar diya

        // App ke Main Colors (Blue & Orange)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C43A8), // Hamara main Blue color
          primary: const Color(0xFF2C43A8),
          secondary: const Color(0xFFFF6B00), // Hamara Orange color
          background: Colors.white,
        ),

        // Scaffold ka background color (Light Grey jo hum use kar rahe hain)
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),

        // AppBar ki default styling
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent, // Material 3 tint hatane ke liye
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),

      // --- 3. Entry Point ---
      // App khulte hi Splash Screen dikhaye
      home: const SplashScreen(),
    );
  }
}