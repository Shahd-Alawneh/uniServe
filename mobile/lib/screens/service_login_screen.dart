import 'package:flutter/material.dart';

class ServiceLoginScreen extends StatefulWidget {
  const ServiceLoginScreen({super.key});

  @override
  State<ServiceLoginScreen> createState() => _ServiceLoginScreenState();
}

class _ServiceLoginScreenState extends State<ServiceLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // بيانات تسجيل الدخول الثابتة (للتجربة)
    const validUsername = 'service_admin';
    const validPassword = '12345';

    if (_usernameController.text == validUsername &&
        _passwordController.text == validPassword) {
      // ✅ بدل الانتقال لصفحة أخرى، نظهر رسالة نجاح فقط
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful! ✅'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // ممكن لاحقاً تضيفي كود هنا لتنفيذ إجراء معين بعد تسجيل الدخول الناجح
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid credentials. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Service Center Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login to Service Center',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
