import 'package:flutter/material.dart';

// --- IMPORTS ---
import 'role_selection_screen.dart';
import 'client_home_screen.dart'; // Client Map Screen
import 'worker_home_screen.dart'; // Worker Dashboard Screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- STATE VARIABLES ---
  bool _obscurePassword = true;

  // [DEV MODE] TESTING VARIABLE:
  // true  = Client Map khulega
  // false = Worker Dashboard khulega
  final bool _isTestingClient = true;

  // --- CONTROLLERS (Data lene ke liye) ---
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- CONSTANTS ---
  final Color _primaryColor = const Color(0xFF2C43A8);
  final Color _accentColor = const Color(0xFFFF6B00);
  final Color _bgColor = const Color(0xFFF7F8FA);

  @override
  void dispose() {
    // Memory leak rokne ke liye controllers dispose karna zaroori hai
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // --- 1. Back Button ---
            SliverAppBar(
              backgroundColor: _bgColor,
              elevation: 0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // --- 2. Main Content ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Logo
                    Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // Headings
                    const Text(
                      'Welcome Back',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please login using the form below.',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                    ),
                    const SizedBox(height: 40),

                    // Inputs
                    _buildTextField(
                      controller: _phoneController,
                      hintText: 'Enter your phone number',
                      isNumber: true,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      isPassword: true,
                      isObscure: _obscurePassword,
                      onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Future: Forgot Password Logic
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontFamily: 'Poppins', color: _accentColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- LOGIN BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ", style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: _primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LOGIC: LOGIN HANDLER
  // ============================================================
  void _handleLogin() {
    // Yahan real backend API call aayegi.
    // Filhal hum Testing Logic use kar rahe hain:

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
  }

  // ============================================================
  // HELPER WIDGET: Reusable Text Field
  // ============================================================
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    bool isObscure = false,
    bool isNumber = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isObscure : false,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.black38),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggleVisibility,
          )
              : null,
        ),
      ),
    );
  }
}