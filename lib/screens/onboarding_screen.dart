import 'package:flutter/material.dart';
import 'role_selection_screen.dart'; // Make sure ye file bani ho

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [

            // -------- SLIDER AREA --------
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildPage1(),
                  _buildPage2(),
                  _buildPage3(),
                ],
              ),
            ),

            // -------- BOTTOM CONTROLS --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => _dot(index)),
                  ),
                  const SizedBox(height: 30),

                  // Buttons
                  _currentIndex == 2
                      ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Role Selection Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RoleSelectionScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C43A8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: const Text('Get Started', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () { _controller.jumpToPage(2); },
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF2C43A8)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), padding: const EdgeInsets.symmetric(vertical: 14)),
                          child: const Text('Skip', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF2C43A8), fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () { _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut); },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C43A8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0),
                          child: const Text('Next', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Page Designs ---
  Widget _buildPage1() {
    return Column(children: [const SizedBox(height: 90), SizedBox(width: 326, height: 264, child: Image.asset('assets/onboarding.png', fit: BoxFit.contain)), const SizedBox(height: 40), const Text('Find Local Experts', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)), const SizedBox(height: 12), const Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Text('Connect with skilled workers in your neighborhood instantly.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black54)))]);
  }

  Widget _buildPage2() {
    return Column(children: [const SizedBox(height: 50), Expanded(flex: 5, child: Image.asset('assets/onboarding2.png', fit: BoxFit.contain)), const SizedBox(height: 20), const Text('Direct Calling', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)), const SizedBox(height: 12), const Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Text('Talk directly to the worker. No middleman, no delays.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black54))), const Spacer()]);
  }

  Widget _buildPage3() {
    return Column(children: [const SizedBox(height: 50), SizedBox(width: 230, height: 369, child: Image.asset('assets/onboarding3.png', fit: BoxFit.contain)), const SizedBox(height: 40), const Text('Track in Real-Time', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)), const SizedBox(height: 12), const Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Text('See exactly when your help will arrive on the live map.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black54)))]);
  }

  Widget _dot(int index) {
    bool isActive = index == _currentIndex;
    return AnimatedContainer(duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn, margin: const EdgeInsets.symmetric(horizontal: 4), height: 8, width: isActive ? 32 : 8, decoration: BoxDecoration(color: isActive ? const Color(0xFFFF7A00) : Colors.grey.shade300, borderRadius: BorderRadius.circular(8)));
  }
}