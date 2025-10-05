import 'dart:convert';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../services/api_service.dart'; // ✅ استدعاء ملف API
import 'signin_screen.dart'; // عشان الانتقال بعد النجاح
=======
import 'package:http/http.dart' as http;
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isMobile
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
<<<<<<< HEAD
=======
                    const SizedBox(height: 0),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
                    Image.asset(
                      'assets/images/signup_illustration.png',
                      height: 180,
                    ),
                    const SizedBox(height: 10),
                    const SignupForm(),
                  ],
                ),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/signup_illustration.png'),
                    ),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0),
<<<<<<< HEAD
                    child: Center(child: SignupForm()),
=======
                    child: Center(
                      child: SignupForm(),
                    ),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
                  ),
                ),
              ],
            ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

<<<<<<< HEAD
=======
  // 🧩 دالة التسجيل
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
  Future<void> registerUser() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields ❌')),
      );
      return;
    }

    final fullName = "$firstName $lastName";

    try {
<<<<<<< HEAD
      final response = await ApiService.signUp(
        fullName: fullName,
        email: email,
        password: password,
=======
      final url = Uri.parse('http://10.0.2.2:5000/api/users/signup'); // للمحاكي
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
        }),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Account created ✅')),
        );

<<<<<<< HEAD
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SigninScreen()),
        );
=======
        // ✅ بعد النجاح، الانتقال لصفحة تسجيل الدخول
        Navigator.pushReplacementNamed(context, '/signin');
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error['message'] ?? 'Error signing up ❌')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fill in your credentials and click on the Sign up button',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.4,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 20),

          // الاسم الأول و الأخير
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

<<<<<<< HEAD
=======
          // الإيميل
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'Please enter your university email',
<<<<<<< HEAD
=======
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
            ),
          ),

          const SizedBox(height: 15),

<<<<<<< HEAD
=======
          // كلمة المرور
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              suffixIcon: Icon(Icons.visibility),
            ),
          ),

          const SizedBox(height: 20),

<<<<<<< HEAD
=======
          // زر التسجيل
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
          ElevatedButton(
            onPressed: registerUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Sign Up'),
          ),

          const SizedBox(height: 18),

<<<<<<< HEAD
=======
          // لديك حساب مسبقاً؟
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              GestureDetector(
                onTap: () {
<<<<<<< HEAD
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SigninScreen()),
                  );
=======
                  Navigator.pushReplacementNamed(context, '/signin');
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.deepPurple),
                ),
<<<<<<< HEAD
              ),
=======
              )
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
            ],
          ),
        ],
      ),
    );
  }
}
