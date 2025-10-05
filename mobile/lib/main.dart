import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/reset_password.dart';
import 'screens/welcome_screen.dart';

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
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartScreen(),
        '/welcome': (context) => const WelcomeScreen(role: 'student'),
        '/signin': (context) => const SigninScreen(),
        '/signup': (context) => const SignupScreen(),
        '/reset': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
