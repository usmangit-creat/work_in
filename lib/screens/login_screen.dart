import 'package:flutter/material.dart';
import 'role_selection_screen.dart';
import 'client_home_screen.dart'; // Client Map Screen
import 'worker_home_screen.dart'; // Worker Dashboard Screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  // TESTING VARIABLE:
  // Isko 'true' karein to Client Map khulega.
  // Isko 'false' karein to Worker Dashboard khulega.
  // (Real app mein ye data API se aayega)
  bool _isTestingClient = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFF7F8FA),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Image.asset('assets/logo.png', height: 100, width: 100, fit: BoxFit.contain),
                    const SizedBox(height: 20),
                    const Text('Welcome Back', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    const Text('Please login using the form below.', style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
                    const SizedBox(height: 40),

                    _buildTextField(hintText: 'Enter your phone number', isNumber: true),
                    const SizedBox(height: 20),
                    _buildTextField(hintText: 'Enter your password', isPassword: true, isObscure: _obscurePassword, onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword)),

                    Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Forgot Password?', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFFF6B00))))),
                    const SizedBox(height: 30),

                    // -------- LOGIC CHANGED HERE --------
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Yahan hum check kar rahe hain ke banda Client hai ya Worker
                          if (_isTestingClient) {
                            // Go to Client Map
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const ClientHomeScreen()),
                                  (route) => false,
                            );
                          } else {
                            // Go to Worker Dashboard
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const WorkerHomeScreen()),
                                  (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C43A8),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Log in', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign Up Link -> Go to Role Selection
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Don't have an account? ", style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen()));
                        },
                        child: const Text('Sign Up', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: Color(0xFF2C43A8))),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, bool isPassword = false, bool isObscure = false, bool isNumber = false, VoidCallback? onToggleVisibility}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        obscureText: isPassword ? isObscure : false,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 14), // Text typing style
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.black38), // Hint style
            filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            suffixIcon: isPassword ? IconButton(icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined, color: Colors.grey), onPressed: onToggleVisibility) : null),
      ),
    );
  }
}