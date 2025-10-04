import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;
  bool codeSent = false;

  // عدّلي هذا العنوان إذا لازم
  final String baseUrl = 'http://10.0.2.2:5000/api/users';

  Future<void> sendResetCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showSnack('Please enter your email');
      return;
    }

    setState(() => isLoading = true);
    try {
      final url = Uri.parse('$baseUrl/forgot-password');
      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}));

      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        showSnack(body['message'] ?? 'Reset code sent to your email');
        setState(() => codeSent = true);
      } else {
        final body = jsonDecode(resp.body);
        showSnack(body['message'] ?? 'Failed to send reset code');
      }
    } catch (e) {
      showSnack('Connection error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    final code = codeController.text.trim();
    final pass = newPassController.text.trim();
    final conf = confirmPassController.text.trim();

    if (email.isEmpty || code.isEmpty || pass.isEmpty || conf.isEmpty) {
      showSnack('Please fill all fields');
      return;
    }
    if (pass != conf) {
      showSnack('Passwords do not match');
      return;
    }
    if (pass.length < 6) {
      showSnack('Password must be at least 6 characters');
      return;
    }

    setState(() => isLoading = true);
    try {
      final url = Uri.parse('$baseUrl/reset-password');
      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'code': code,
            'newPassword': pass,
          }));

      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        showSnack(body['message'] ?? 'Password reset successful');
        // بعد نجاح الريست، نرجع لصفحة الـ SignIn
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/signin');
        });
      } else {
        final body = jsonDecode(resp.body);
        showSnack(body['message'] ?? 'Reset failed');
      }
    } catch (e) {
      showSnack('Connection error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Forgot Password',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your email to receive a verification code, then enter the code and your new password.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 12),

            // زر إرسال الكود
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : sendResetCode,
                child: isLoading
                    ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(codeSent ? 'Resend Code' : 'Send Verification Code'),
              ),
            ),
            const SizedBox(height: 18),

            // لو الكود اتبعت، نبين الحقول التالية
            if (codeSent) ...[
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Verification Code',
                  prefixIcon: Icon(Icons.confirmation_num_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPassController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmPassController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : resetPassword,
                  child: isLoading
                      ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Reset Password'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
