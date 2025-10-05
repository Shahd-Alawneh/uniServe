import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/start_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/reset_password.dart';
import 'screens/welcome_screen.dart';
=======
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/reset_password.dart';
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f

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
<<<<<<< HEAD
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartScreen(),
        '/welcome': (context) => const WelcomeScreen(role: 'student'),
=======
      // ✅ نبدأ من صفحة التسجيل (Sign Up)
      initialRoute: '/signup',
      routes: {
>>>>>>> 6e5706d374dcc1f382712f0320126ff8d193055f
        '/signin': (context) => const SigninScreen(),
        '/signup': (context) => const SignupScreen(),
        '/reset': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
