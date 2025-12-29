import 'package:flutter/material.dart';
import 'login_screen.dart';
// --- IMPORTS FOR NAVIGATION ---
import 'client_home_screen.dart';
import 'worker_home_screen.dart';

class SignupScreen extends StatefulWidget {
  final String userRole;
  const SignupScreen({super.key, required this.userRole});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Variables
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedGender = 'Male';

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

                    // --- Dynamic Title ---
                    Text(
                      widget.userRole == 'Worker' ? 'Join as a Worker' : 'Find a Service',
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    const Text('Please enter the information below.', style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
                    const SizedBox(height: 30),

                    // --- Form Fields ---

                    // 1. Name
                    _buildLabel('Name'), // <--- YE MISSING THA, AB LAGA DIYA
                    _buildTextField(hintText: 'Enter your name'),
                    const SizedBox(height: 16),

                    // 2. Phone
                    _buildLabel('Phone no.'), // <--- LABEL ADDED
                    _buildTextField(hintText: 'Phone number', isNumber: true),
                    const SizedBox(height: 16),

                    // 3. Password
                    _buildLabel('New Password'), // <--- LABEL ADDED
                    _buildTextField(hintText: 'Password', isPassword: true, isObscure: _obscurePassword, onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword)),
                    const SizedBox(height: 16),

                    // 4. Confirm Password
                    _buildLabel('Confirm Password'), // <--- LABEL ADDED
                    _buildTextField(hintText: 'Confirm Password', isPassword: true, isObscure: _obscureConfirmPassword, onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)),
                    const SizedBox(height: 16),

                    // Gender
                    Row(children: [
                      const Text('Gender', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                      const Spacer(),
                      _buildRadio('Male'), const SizedBox(width: 15), _buildRadio('Female'),
                    ]),
                    const SizedBox(height: 40),

                    // --- SIGN UP BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.userRole == 'Worker') {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const WorkerHomeScreen()),
                                  (route) => false,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const ClientHomeScreen()),
                                  (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C43A8),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Sign Up', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Login Link
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already have an account? ", style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                        child: const Text('Login', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Color(0xFF2C43A8))),
                      ),
                    ]),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper: Label Widget (Jo Missing Tha) ---
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // --- Helper: TextField Widget ---
  Widget _buildTextField({required String hintText, bool isPassword = false, bool isObscure = false, bool isNumber = false, VoidCallback? onToggleVisibility}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        obscureText: isPassword ? isObscure : false,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        style: const TextStyle(fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: hintText, hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.black38),
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          suffixIcon: isPassword ? IconButton(icon: Icon(isObscure ? Icons.visibility_off : Icons.remove_red_eye, color: Colors.grey), onPressed: onToggleVisibility) : null,
        ),
      ),
    );
  }

  Widget _buildRadio(String val) => Row(children: [
    Radio(value: val, groupValue: _selectedGender, activeColor: const Color(0xFF2C43A8), onChanged: (v) => setState(() => _selectedGender = v.toString())),
    Text(val, style: const TextStyle(fontFamily: 'Poppins')),
  ]);
}