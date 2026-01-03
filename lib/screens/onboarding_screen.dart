import 'package:flutter/material.dart';
import 'role_selection_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // --- Controllers ---
  final PageController _controller = PageController();
  int _currentIndex = 0;

  // --- Constants for Colors ---
  final Color _primaryColor = const Color(0xFF2C43A8);
  final Color _accentColor = const Color(0xFFFF7A00);

  @override
  void dispose() {
    _controller.dispose(); // Memory leak rokne ke liye controller dispose karna zaroori hai
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [

            // ============================================================
            // 1. SLIDER AREA (PageView)
            // ============================================================
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: [
                  // Page 1: Find Experts
                  _buildPageContent(
                    imagePath: 'assets/onboarding.png',
                    title: 'Find Local Experts',
                    subtitle: 'Connect with skilled workers in your neighborhood instantly.',
                    imageHeight: 264,
                    imageWidth: 326,
                    topSpacing: 90,
                  ),

                  // Page 2: Direct Calling (Thoda different layout hai iska)
                  _buildPage2(),

                  // Page 3: Track Real-Time
                  _buildPageContent(
                    imagePath: 'assets/onboarding3.png',
                    title: 'Track in Real-Time',
                    subtitle: 'See exactly when your help will arrive on the live map.',
                    imageHeight: 369,
                    imageWidth: 230,
                    topSpacing: 50,
                  ),
                ],
              ),
            ),

            // ============================================================
            // 2. BOTTOM CONTROLS
            // ============================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [

                  // --- Dots Indicator ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => _buildDot(index)),
                  ),
                  const SizedBox(height: 30),

                  // --- Buttons (Next / Get Started) ---
                  _currentIndex == 2
                      ? _buildGetStartedButton()
                      : _buildNavButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================

  /// Generic Page Builder for Page 1 & 3
  Widget _buildPageContent({
    required String imagePath,
    required String title,
    required String subtitle,
    required double imageHeight,
    required double imageWidth,
    required double topSpacing,
  }) {
    return Column(
      children: [
        SizedBox(height: topSpacing),
        SizedBox(
          width: imageWidth,
          height: imageHeight,
          child: _buildOptimizedImage(imagePath),
        ),
        const SizedBox(height: 40),
        _buildTextContent(title, subtitle),
      ],
    );
  }

  /// Specific Builder for Page 2 (Kyunke isme Expanded/Spacer use hua tha)
  Widget _buildPage2() {
    return Column(
      children: [
        const SizedBox(height: 50),
        Expanded(
          flex: 5,
          child: _buildOptimizedImage('assets/onboarding2.png'),
        ),
        const SizedBox(height: 20),
        _buildTextContent(
          'Direct Calling',
          'Talk directly to the worker. No middleman, no delays.',
        ),
        const Spacer(),
      ],
    );
  }

  /// Text Styling Helper
  Widget _buildTextContent(String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  /// Optimized Image Loader (Fade In + Memory Saving)
  Widget _buildOptimizedImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.contain,
      cacheWidth: 600, // Memory Optimization
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );
  }

  /// Animated Dot Indicator
  Widget _buildDot(int index) {
    bool isActive = index == _currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
        color: isActive ? _accentColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// "Get Started" Button (Last Page)
  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 0,
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// "Skip" & "Next" Buttons
  Widget _buildNavButtons() {
    return Row(
      children: [
        // Skip Button
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              _controller.jumpToPage(2);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: _primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Next Button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}