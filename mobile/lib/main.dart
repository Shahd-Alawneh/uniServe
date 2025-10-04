import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/reset_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniServe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // ✅ نبدأ من صفحة التسجيل (Sign Up)
      initialRoute: '/signup',
      routes: {
        '/signin': (context) => const SigninScreen(),
        '/signup': (context) => const SignupScreen(),
        '/reset': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
