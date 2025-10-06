import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';
import 'service_login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String role;
  const WelcomeScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(), // فراغ من الأعلى

            const Text(
              'Welcome 👋',
              style: TextStyle(
                fontSize: 26,
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

            // 🔹 زر تسجيل الدخول
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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

            // 🔹 زر التسجيل
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.deepPurple, width: 2),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: const Text(
                'Register ',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),

            const Spacer(), // فراغ قبل النص السفلي

            // 🏢 رابط بسيط أسفل الصفحة لمركز الخدمة
           // 🏢 رابط بسيط أسفل الصفحة لمركز الخدمة
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServiceLoginScreen()),
    );
  },
  child: Column(
    children: [
      const Text(
        'Service Center',
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Click here to login',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.arrow_forward, size: 16, color: Colors.deepPurple),
        ],
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}
