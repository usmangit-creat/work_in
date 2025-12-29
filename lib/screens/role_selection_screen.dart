import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Import zaroori hai

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  int _selectedRole = -1;

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

              // -------- Card 1: Client --------
              _buildSpecCard(
                index: 0,
                title: 'I need a service',
                imageAsset: 'assets/role_client.png',
                isActive: _selectedRole == 0,
                isImageLeft: true,
              ),

              const SizedBox(height: 30),

              // -------- Card 2: Worker --------
              _buildSpecCard(
                index: 1,
                title: 'I want to Work',
                imageAsset: 'assets/role_worker.png',
                isActive: _selectedRole == 1,
                isImageLeft: false,
              ),

              const Spacer(),

              // -------- Continue Button --------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedRole == -1
                      ? null
                      : () {
                    // Check Role
                    String roleToSend =
                    _selectedRole == 0 ? 'Client' : 'Worker';

                    // Navigate to Signup with Role
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(
                          userRole: roleToSend,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C43A8),
                    disabledBackgroundColor:
                    const Color(0xFF2C43A8).withOpacity(0.5),
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

  // --- Card Widget (Image Inside Box + Border Overlay) ---
  Widget _buildSpecCard({
    required int index,
    required String title,
    required String imageAsset,
    required bool isActive,
    required bool isImageLeft,
  }) {
    const double cardHeight = 100;
    final borderColor = isActive ? const Color(0xFFFF6B00) : Colors.transparent;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = index;
        });
      },
      child: SizedBox(
        height: cardHeight,
        width: double.infinity,
        child: Stack(
          children: [
            // Layer 1: Content
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
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                      ),
                    ),
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
            // Layer 2: Border
            Container(
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