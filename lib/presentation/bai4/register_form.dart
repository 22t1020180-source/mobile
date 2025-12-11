import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

const Color kPrimaryBlue = Color(0xFF1d293d);
const Color kErrorColor = Color(0xFFE57373);

class RegisterForm extends StatefulWidget {
  final VoidCallback onLoginTap;

  const RegisterForm({super.key, required this.onLoginTap});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  void _handleRegister() {
    setState(() {
      _nameError = _nameController.text.isEmpty
          ? 'Vui lòng nhập tên người dùng'
          : null;
      _emailError = _emailController.text.isEmpty
          ? 'Vui lòng nhập email'
          : (!_emailController.text.contains('@')
                ? 'Email không hợp lệ'
                : null);
      _passwordError = _passwordController.text.isEmpty
          ? 'Vui lòng nhập mật khẩu'
          : (_passwordController.text.length < 6
                ? 'Mật khẩu >= 6 ký tự'
                : null);
      _confirmError = _confirmPasswordController.text.isEmpty
          ? 'Vui lòng xác nhận mật khẩu'
          : (_confirmPasswordController.text != _passwordController.text
                ? 'Mật khẩu không khớp'
                : null);
    });

    if (_nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmError == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang xử lý đăng ký')));
    }
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData prefixIcon,
    Widget? suffixIcon,
    bool hasError = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: hasError ? kErrorColor : Colors.grey[600],
        fontSize: 14,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: hasError ? kErrorColor : Colors.grey[600],
        size: 22,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: hasError ? kErrorColor : Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: hasError ? kErrorColor : const Color(0xFF4CAF50),
          width: 2,
        ),
      ),
    );
  }

  Widget _buildErrorText(String? error) {
    if (error == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Text(
        error,
        style: const TextStyle(color: kErrorColor, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Name Field
        TextField(
          controller: _nameController,
          decoration: _buildInputDecoration(
            label: 'Họ tên',
            prefixIcon: Iconsax.user,
            hasError: _nameError != null,
          ),
          onChanged: (_) {
            if (_nameError != null) setState(() => _nameError = null);
          },
        ),
        _buildErrorText(_nameError),
        const SizedBox(height: 16),

        // Email Field
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _buildInputDecoration(
            label: 'Email',
            prefixIcon: Iconsax.sms,
            hasError: _emailError != null,
          ),
          onChanged: (_) {
            if (_emailError != null) setState(() => _emailError = null);
          },
        ),
        _buildErrorText(_emailError),
        const SizedBox(height: 16),

        // Password Field
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: _buildInputDecoration(
            label: 'Mật khẩu',
            prefixIcon: Iconsax.lock,
            hasError: _passwordError != null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                color: kErrorColor,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          onChanged: (_) {
            if (_passwordError != null) setState(() => _passwordError = null);
          },
        ),
        _buildErrorText(_passwordError),
        const SizedBox(height: 16),

        // Confirm Password Field
        TextField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirm,
          decoration: _buildInputDecoration(
            label: 'Xác nhận mật khẩu',
            prefixIcon: Iconsax.lock,
            hasError: _confirmError != null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm ? Iconsax.eye : Iconsax.eye_slash,
                color: kErrorColor,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          onChanged: (_) {
            if (_confirmError != null) setState(() => _confirmError = null);
          },
        ),
        _buildErrorText(_confirmError),

        const SizedBox(height: 30),

        // Register Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: _handleRegister,
            icon: const Icon(Iconsax.user_add, color: Colors.white, size: 20),
            label: const Text(
              'Đăng ký',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
          ),
        ),

        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đã có tài khoản? ',
              style: TextStyle(color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: widget.onLoginTap,
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
