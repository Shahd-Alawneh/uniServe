import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_service.dart'; // ✅ استدعاء ملف الـ API

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

  // ✅ إرسال كود التحقق إلى الإيميل
  Future<void> sendResetCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showSnack('Please enter your email');
      return;
    }

    setState(() => isLoading = true);
    try {
      final response = await ApiService.sendResetCode(email: email);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnack(body['message'] ?? 'Reset code sent to your email');
        setState(() => codeSent = true);
      } else {
        showSnack(body['message'] ?? 'Failed to send reset code');
      }
    } catch (e) {
      showSnack('Connection error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ✅ إعادة تعيين كلمة المرور
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
      final response = await ApiService.resetPassword(
        email: email,
        code: code,
        newPassword: pass,
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnack(body['message'] ?? 'Password reset successful ✅');
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/signin');
        });
      } else {
        showSnack(body['message'] ?? 'Reset failed ❌');
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
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : Text(codeSent ? 'Resend Code' : 'Send Verification Code'),
              ),
            ),
            const SizedBox(height: 18),

            // لو الكود اتبعت، بنظهر الحقول التالية
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
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
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
