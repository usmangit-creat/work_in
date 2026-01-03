import 'package:flutter/material.dart';

// --- IMPORTS ---
import 'login_screen.dart';
import 'client_home_screen.dart';
import 'worker_home_screen.dart';

class SignupScreen extends StatefulWidget {
  final String userRole; // 'Client' or 'Worker'
  const SignupScreen({super.key, required this.userRole});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // --- STATE VARIABLES ---
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedGender = 'Male';

  // --- CONTROLLERS (Data lene ke liye) ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // --- CONSTANTS ---
  final Color _primaryColor = const Color(0xFF2C43A8);
  final Color _bgColor = const Color(0xFFF7F8FA);

  @override
  void dispose() {
    // Memory leak rokne ke liye controllers dispose karna zaroori hai
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // --- 1. Back Button AppBar ---
            SliverAppBar(
              backgroundColor: _bgColor,
              elevation: 0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // --- 2. Main Body ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // --- HEADER SECTION ---
                    _buildHeader(),

                    const SizedBox(height: 30),

                    // --- FORM SECTION ---
                    _buildForm(),

                    const SizedBox(height: 40),

                    // --- FOOTER SECTION (Button & Link) ---
                    _buildFooter(),

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

  // ============================================================
  // SECTION 1: HEADER (Logo & Title)
  // ============================================================
  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          height: 100,
          width: 100,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, size: 80, color: Colors.grey),
        ),
        const SizedBox(height: 20),

        // Dynamic Title based on Role
        Text(
          widget.userRole == 'Worker' ? 'Join as a Worker' : 'Find a Service',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Please enter the information below.',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION 2: FORM FIELDS
  // ============================================================
  Widget _buildForm() {
    return Column(
      children: [
        // 1. Name
        _buildLabel('Name'),
        _buildTextField(
          controller: _nameController,
          hintText: 'Enter your name',
          inputType: TextInputType.name,
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        // 2. Phone
        _buildLabel('Phone no.'),
        _buildTextField(
          controller: _phoneController,
          hintText: 'Phone number',
          inputType: TextInputType.phone,
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        // 3. Password
        _buildLabel('New Password'),
        _buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          isPassword: true,
          isObscure: _obscurePassword,
          onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        // 4. Confirm Password
        _buildLabel('Confirm Password'),
        _buildTextField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
          isPassword: true,
          isObscure: _obscureConfirmPassword,
          onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          action: TextInputAction.done,
        ),
        const SizedBox(height: 16),

        // 5. Gender Selection
        Row(
          children: [
            const Text(
              'Gender',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            _buildRadio('Male'),
            const SizedBox(width: 15),
            _buildRadio('Female'),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // SECTION 3: FOOTER (Button & Login Link)
  // ============================================================
  Widget _buildFooter() {
    return Column(
      children: [
        // Sign Up Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleSignup,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Login Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? ", style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // LOGIC: SIGNUP HANDLER
  // ============================================================
  void _handleSignup() {
    // Future: Add Validation here (e.g. check if name is empty)

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
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================

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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    bool isObscure = false,
    TextInputType inputType = TextInputType.text,
    TextInputAction action = TextInputAction.done,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Subtle Shadow
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
        keyboardType: inputType,
        textInputAction: action,
        style: const TextStyle(fontFamily: 'Poppins'),
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

  Widget _buildRadio(String val) {
    return Row(
      children: [
        Radio(
          value: val,
          groupValue: _selectedGender,
          activeColor: _primaryColor,
          onChanged: (v) => setState(() => _selectedGender = v.toString()),
        ),
        Text(val, style: const TextStyle(fontFamily: 'Poppins')),
      ],
    );
  }
}