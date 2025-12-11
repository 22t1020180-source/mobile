import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:iconsax/iconsax.dart';

const Color kPrimaryColor = Color(0xFF1d293d);

// -----------------------------------------------------------------------------
// MODEL
// -----------------------------------------------------------------------------
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? 'https://robohash.org/placeholder.png',
    );
  }

  String get fullName => '$firstName $lastName';
}

// -----------------------------------------------------------------------------
// SCREEN
// -----------------------------------------------------------------------------
class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({super.key});

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  final Dio _dio = Dio();

  // State
  bool _isLoading = false;
  User? _currentUser;
  String? _accessToken;
  String? _refreshToken;

  // Controllers
  final TextEditingController _usernameController = TextEditingController(
    text: 'emilys',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'emilyspass',
  );
  bool _obscurePassword = true;

  // ---------------------------------------------------------------------------
  // API METHODS
  // ---------------------------------------------------------------------------

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'expiresInMins': 30,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _accessToken =
              data['token']; // DummyJSON returns 'token' or 'accessToken'? Docs say accessToken but sometimes it's token. Let's check response structure usually.
          // Actually dummyjson returns 'token' (jwt) AND 'refreshToken'.
          // Wait, recent docs say 'accessToken' and 'refreshToken'. Let's trust standard but handle flexibility if needed.
          // For safety, let's grab 'accessToken' ?? 'token'.
          _accessToken = data['accessToken'] ?? data['token'];
          _refreshToken = data['refreshToken'];
          _currentUser = User.fromJson(data);
        });
        _showSnackBar('Đăng nhập thành công!', Colors.green);
      }
    } catch (e) {
      _showSnackBar('Đăng nhập thất bại: ${e.toString()}', Colors.red);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshTokenFunc() async {
    if (_refreshToken == null) return;
    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/refresh',
        data: {'refreshToken': _refreshToken, 'expiresInMins': 30},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _accessToken = data['accessToken'] ?? data['token'];
          _refreshToken = data['refreshToken'];
        });
        _showSnackBar('Đã làm mới Token!', Colors.green);
      }
    } catch (e) {
      _showSnackBar(
        'Làm mới thất bại: Phiên đăng nhập có thể đã hết hạn',
        Colors.red,
      );
      _logout();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logout() {
    setState(() {
      _accessToken = null;
      _refreshToken = null;
      _currentUser = null;
      _usernameController.text = 'emilys';
      _passwordController.text = 'emilyspass';
    });
    _showSnackBar('Đã đăng xuất', Colors.black54);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INPUT DECORATION
  // ---------------------------------------------------------------------------
  InputDecoration _buildInputDecoration({
    required String label,
    required IconData prefixIcon,
    Widget? suffixIcon,
    bool hasError = false,
  }) {
    const errorColor = Color(0xFFE57373);
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: hasError ? errorColor : Colors.grey[600],
        fontSize: 14,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: hasError ? errorColor : Colors.grey[600],
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
          color: hasError ? errorColor : Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: hasError ? errorColor : const Color(0xFF4CAF50),
          width: 2,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UI BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Determine screen content based on login state
    final isLogged = _currentUser != null && _accessToken != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(child: isLogged ? _buildProfileView() : _buildLoginView()),
    );
  }

  // --- Login View ---
  Widget _buildLoginView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                  color: const Color(0xFFE57373),
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _login,
              icon: _isLoading
                  ? const SizedBox.shrink()
                  : const Icon(Iconsax.login, color: Colors.white, size: 20),
              label: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1d293d),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 0,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Demo Hint
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Demo: emilys / emilyspass',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản? ',
                style: TextStyle(color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () {
                  _showSnackBar(
                    'Chức năng đăng ký chưa được thực hiện',
                    Colors.black54,
                  );
                },
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1d293d),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Profile View ---
  Widget _buildProfileView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Background with Avatar
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1d293d), Color(0xFF3d5a80)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(_currentUser!.image),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70), // Space for Avatar
          // Greeting
          Text(
            "Xin chào, ${_currentUser!.firstName}!",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Bạn đang đăng nhập với tư cách thành viên",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 30),

          // Content Container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Thông tin hồ sơ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Info List
                _buildInfoTile("ID", _currentUser!.id.toString(), Iconsax.card),
                _buildInfoTile(
                  "Tên đăng nhập",
                  _currentUser!.username,
                  Iconsax.user,
                ),
                _buildInfoTile("Email", _currentUser!.email, Iconsax.sms),
                _buildInfoTile(
                  "Họ và tên",
                  _currentUser!.fullName,
                  Iconsax.profile_circle,
                ),
                _buildInfoTile("Giới tính", _currentUser!.gender, Iconsax.man),

                const SizedBox(height: 30),
                const Text(
                  "Hành động",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        label: "Làm mới",
                        icon: Iconsax.refresh,
                        color: Colors.blue.shade50,
                        iconColor: Colors.blue,
                        onTap: _refreshTokenFunc,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildActionButton(
                        label: "Đăng xuất",
                        icon: Iconsax.logout,
                        color: const Color(0xFFE8EEF5), // Light Blue
                        iconColor: const Color(0xFF1d293d), // Primary Color
                        onTap: _logout,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF6A85B6)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color, // Light background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
