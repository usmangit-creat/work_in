import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart'; // Ensure ye import sahi ho
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  // --- VARIABLES ---
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  Timer? _timer; // Timer variable taake hum isay cancel kar sakein

  @override
  void initState() {
    super.initState();

    // 1. Setup Animations
    _setupAnimations();

    // 2. Start Navigation Timer
    _timer = Timer(const Duration(seconds: 3), _navigateToNextScreen);
  }

  // --- LOGIC: Setup Animations ---
  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  // --- LOGIC: Navigation ---
  void _navigateToNextScreen() {
    // Check mounted: Agar user app band kar chuka ho to navigate na kare (Crash fix)
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        // Transition Duration (Smoothness)
        transitionDuration: const Duration(milliseconds: 800),

        // Target Screen
        pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),

        // Fade Animation
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Important: Timer stop karna zaroori hai
    _controller.dispose(); // Memory free karna
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Logo ---
                Image.asset(
                  'assets/logo.png',
                  width: 160,
                  height: 160,
                  // Smooth loading check
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                ),

                const SizedBox(height: 10), // Spacing thoda barha diya

                // --- Brand Name ---
                const Text(
                  'WorkIn',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}