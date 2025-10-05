import 'dart:convert';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../services/api_service.dart'; // ✅ استيراد ملف الاتصال بالسيرفر
=======
import 'package:http/http.dart' as http;
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
import 'reset_password.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool showPassword = false;

  // 🟢 دالة تسجيل الدخول
  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields ❌")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
<<<<<<< HEAD
      // ✅ استدعاء الدالة من api_service.dart
      final response = await ApiService.signIn(email: email, password: password);

=======
      final url = Uri.parse('http://10.0.2.2:5000/api/users/signIn');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // ✅ حالة النجاح
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Login successful ✅'),
            backgroundColor: Colors.green,
          ),
        );

<<<<<<< HEAD
        // تنظيف الحقول
=======
        // تفريغ الحقول
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
        emailController.clear();
        passwordController.clear();

        // الانتقال لصفحة الـ Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
<<<<<<< HEAD
      } else {
=======

      } else {
        // ❌ فشل تسجيل الدخول
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error['message'] ?? 'Invalid email or password ❌'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
<<<<<<< HEAD
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection error: $e'),
=======
      // ⚠️ خطأ في الاتصال بالسيرفر
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection error: ${e.toString()}'),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
          backgroundColor: Colors.orangeAccent,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
<<<<<<< HEAD
              // صورة تسجيل الدخول
              Image.asset('assets/images/login.png', height: 160),

              const SizedBox(height: 20),
=======
              // 🔹 صورة الشاشة
              Image.asset('assets/images/login.png', height: 160),

              const SizedBox(height: 20),

>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              const Text(
                "Welcome Back 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
<<<<<<< HEAD
=======

>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              const Text(
                "Please log in to your account",
                style: TextStyle(color: Colors.grey),
              ),
<<<<<<< HEAD
              const SizedBox(height: 30),

              // حقل الإيميل
=======

              const SizedBox(height: 30),

              // 📧 حقل الإيميل
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 15),

              // حقل كلمة المرور
=======

              const SizedBox(height: 15),

              // 🔒 حقل كلمة المرور
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              TextField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
<<<<<<< HEAD
                      setState(() => showPassword = !showPassword);
=======
                      setState(() {
                        showPassword = !showPassword;
                      });
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
                    },
                  ),
                ),
              ),
<<<<<<< HEAD
=======

>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
<<<<<<< HEAD
                        builder: (context) => const ResetPasswordScreen(),
                      ),
=======
                          builder: (context) => const ResetPasswordScreen()),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 10),

              // زر تسجيل الدخول
=======

              const SizedBox(height: 10),

              // 🔘 زر تسجيل الدخول
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              ElevatedButton(
                onPressed: isLoading ? null : loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
<<<<<<< HEAD
                    borderRadius: BorderRadius.circular(8),
                  ),
=======
                      borderRadius: BorderRadius.circular(8)),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 20),

              // رابط التسجيل
=======

              const SizedBox(height: 20),

              // 🔹 رابط الانتقال لصفحة التسجيل
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✳️ صفحة مؤقتة بعد تسجيل الدخول الناجح
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(
        child: Text(
          "Welcome to UniServe 🎓",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
