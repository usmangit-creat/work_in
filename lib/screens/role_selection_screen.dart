import 'package:flutter/material.dart';
import 'signup_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  // --- State Variable ---
  // -1: None, 0: Client, 1: Worker
  int _selectedRole = -1;

  // --- Constants ---
  final Color _primaryColor = const Color(0xFF2C43A8);
  final Color _accentColor = const Color(0xFFFF6B00);

  // --- Logic: Navigation ---
  void _handleContinue() {
    String roleToSend = _selectedRole == 0 ? 'Client' : 'Worker';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(userRole: roleToSend),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // --- Header ---
              const Text(
                'Choose your role',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 70),

              // --- Card 1: Client ---
              RoleCard(
                title: 'I need a service',
                imageAsset: 'assets/User.png',
                isActive: _selectedRole == 0,
                isImageLeft: true,
                activeColor: _accentColor,
                onTap: () => setState(() => _selectedRole = 0),
              ),

              const SizedBox(height: 30),

              // --- Card 2: Worker ---
              RoleCard(
                title: 'I want to Work',
                imageAsset: 'assets/Worker.png',
                isActive: _selectedRole == 1,
                isImageLeft: false,
                activeColor: _accentColor,
                onTap: () => setState(() => _selectedRole = 1),
              ),

              const Spacer(),

              // --- Continue Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedRole == -1 ? null : _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    disabledBackgroundColor: _primaryColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// EXTRACTED WIDGET:
// ============================================================
class RoleCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final bool isActive;
  final bool isImageLeft;
  final Color activeColor;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.isActive,
    required this.isImageLeft,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 100;
    final borderColor = isActive ? activeColor : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: cardHeight,
        width: double.infinity,
        child: Stack(
          children: [
            // Layer 1: Content Box
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Image Position logic
                    Positioned(
                      bottom: 0,
                      left: isImageLeft ? 10 : null,
                      right: isImageLeft ? null : 10,
                      child: Image.asset(
                        imageAsset,
                        height: 90,
                        width: 120,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        filterQuality: FilterQuality.medium, // Optimized
                        cacheWidth: 300, // Memory Optimization

                        // Smooth Loading
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) return child;
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(milliseconds: 300),
                            child: child,
                          );
                        },
                      ),
                    ),

                    // Text Position logic
                    Align(
                      alignment: isImageLeft
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: isImageLeft ? 0 : 30,
                          right: isImageLeft ? 30 : 0,
                        ),
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Layer 2: Animated Border Overlay
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}