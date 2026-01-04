import 'package:flutter/material.dart';

// --- IMPORTS ---
import '../services/auth_service.dart';
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
  bool _isLoading = false;
  String _selectedGender = 'Male';

  // --- CONTROLLERS ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // --- COLORS ---
  final Color _primaryColor = const Color(0xFF2C43A8);
  final Color _bgColor = const Color(0xFFF7F8FA);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIC: HANDLE SIGNUP (With Verification)
  // ============================================================
  void _handleSignup() async {
    // 1. Validation
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    setState(() { _isLoading = true; });

    // 2. Call Backend
    String res = await AuthService().signUpUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      role: widget.userRole,
      gender: _selectedGender,
    );

    setState(() { _isLoading = false; });

    // 3. Handle Result
    if (res == "success") {
      // Success: Show Dialog telling user to verify email
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Verification Sent"),
          content: const Text("We have sent an email to your address. Please click the link in that email to verify your account, then Login."),
          actions: [
            TextButton(
              onPressed: () {
                // Dialog band karein aur Login screen par le jayen
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
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
                    _buildHeader(),
                    const SizedBox(height: 30),
                    _buildForm(),
                    const SizedBox(height: 40),
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
  // WIDGET HELPER METHODS
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

  Widget _buildForm() {
    return Column(
      children: [
        _buildLabel('Name'),
        _buildTextField(
          controller: _nameController,
          hintText: 'Enter your name',
          inputType: TextInputType.name,
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        _buildLabel('Email Address'),
        _buildTextField(
          controller: _emailController,
          hintText: 'Enter your email',
          inputType: TextInputType.emailAddress,
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        _buildLabel('Phone no.'),
        _buildTextField(
          controller: _phoneController,
          hintText: 'Phone number',
          inputType: TextInputType.phone,
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        _buildLabel('New Password'),
        _buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          isPassword: true,
          isObscure: _obscurePassword,
          onToggleVisibility: () =>
              setState(() => _obscurePassword = !_obscurePassword),
          action: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        _buildLabel('Confirm Password'),
        _buildTextField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
          isPassword: true,
          isObscure: _obscureConfirmPassword,
          onToggleVisibility: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
          action: TextInputAction.done,
        ),
        const SizedBox(height: 16),

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

  Widget _buildFooter() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSignup,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2),
            )
                : const Text(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ),
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
          hintStyle:
          const TextStyle(fontFamily: 'Poppins', color: Colors.black38),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.remove_red_eye_outlined,
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