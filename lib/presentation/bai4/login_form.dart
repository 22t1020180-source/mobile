import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

const Color kPrimaryBlue = Color(0xFF3D5A80);
const Color kErrorColor = Color(0xFFE57373);

class LoginForm extends StatefulWidget {
  final VoidCallback onRegisterTap;

  const LoginForm({super.key, required this.onRegisterTap});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _usernameError;
  String? _passwordError;

  void _handleLogin() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty
          ? 'Vui lòng nhập tên người dùng'
          : null;
      _passwordError = _passwordController.text.length < 6
          ? 'Mật khẩu >= 6 ký tự'
          : null;
    });

    if (_usernameError == null && _passwordError == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang xử lý đăng nhập')));
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          // Username Field
          TextField(
            controller: _usernameController,
            decoration: _buildInputDecoration(
              label: 'Tên người dùng',
              prefixIcon: Iconsax.user,
              hasError: _usernameError != null,
            ),
            onChanged: (_) {
              if (_usernameError != null) {
                setState(() => _usernameError = null);
              }
            },
          ),
          if (_usernameError != null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                _usernameError!,
                style: const TextStyle(color: kErrorColor, fontSize: 12),
              ),
            ),
          const SizedBox(height: 20),

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
              if (_passwordError != null) {
                setState(() => _passwordError = null);
              }
            },
          ),
          if (_passwordError != null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                _passwordError!,
                style: const TextStyle(color: kErrorColor, fontSize: 12),
              ),
            ),

          const SizedBox(height: 30),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _handleLogin,
              icon: const Icon(Iconsax.login, color: Colors.white, size: 20),
              label: const Text(
                'Đăng nhập',
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

          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản? ',
                style: TextStyle(color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: widget.onRegisterTap,
                child: const Text(
                  'Đăng ký',
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
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
