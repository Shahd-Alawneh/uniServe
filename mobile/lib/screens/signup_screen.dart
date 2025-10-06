import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'signin_screen.dart';
import 'upload_photo_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String selectedRole = ''; // doctor or student
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your role ❌')),
      );
      return;
    }

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields ❌')),
      );
      return;
    }

    // ✅ تحقق من إيميل الجامعة إذا كان طالب
    if (selectedRole == 'student' && !email.endsWith('@najah.edu')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please use your university email (@najah.edu) ❌')),
      );
      return;
    }

    try {
      final response = await ApiService.signUp(
  fullName: name,
  email: email,
  password: password,
  role: selectedRole, // ✅ نرسل الدور فعليًا
);


      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Account created ✅')),
        );

       Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => UploadPhotoScreen(userEmail: email),
  ),
);

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/signup_illustration.png', height: 150),
            const SizedBox(height: 25),

            const Text(
              'Select your role to sign up:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),

            // 🔘 اختيار الدور
            ToggleButtons(
              isSelected: [
                selectedRole == 'student',
                selectedRole == 'doctor',
              ],
              onPressed: (int index) {
                setState(() {
                  selectedRole = index == 0 ? 'student' : 'doctor';
                });
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.deepPurple,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Student'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Doctor'),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // 🧾 الحقول
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: selectedRole == 'student'
                    ? 'example@najah.edu'
                    : 'Enter your email',
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: 25),

            // 🔘 زر التسجيل
            ElevatedButton(
              onPressed: registerUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Sign Up'),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SigninScreen()),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
