import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'service_login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to UniServe',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/welcome.jpg',
                  height: 180,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Please choose your role:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),

                // زر الطالب
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const WelcomeScreen(role: 'student'),
                      ),
                    );
                  },
                  child: const Text('Student'),
                ),
                const SizedBox(height: 20),

                // زر مركز الخدمة
                // زر مركز الخدمة
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServiceLoginScreen()),
    );
  },
  child: const Text('Service Center'),
),

                const SizedBox(height: 20),

                // زر الدكتور
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const WelcomeScreen(role: 'doctor'),
                      ),
                    );
                  },
                  child: const Text('Doctor'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
