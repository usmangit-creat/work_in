import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Sirf Splash Screen import karni hai

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug banner hatane ke liye
      title: 'WorkIn App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Yahan hum Home ki jagah Splash Screen laga rahe hain
      home: const SplashScreen(),
    );
  }
}

