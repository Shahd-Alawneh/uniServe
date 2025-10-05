import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String role;
  const WelcomeScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $role 👋',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please choose an action:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),

            // زر تسجيل الدخول
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninScreen()),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),

            // زر إنشاء حساب جديد
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.deepPurple, width: 2),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
