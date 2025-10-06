import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000/api/users";

  // ✅ إنشاء حساب جديد
  static Future<http.Response> signUp({
    required String fullName,
    required String email,
    required String password,
     required String role,
  }) async {
    final url = Uri.parse('$baseUrl/signup');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'password': password,
        "role": role,
      }),
    );
  }

  // ✅ تسجيل الدخول
  static Future<http.Response> signIn({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/signIn');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // ✅ إرسال كود التحقق
  static Future<http.Response> sendResetCode({required String email}) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  // ✅ إعادة تعيين كلمة المرور
  static Future<http.Response> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/reset-password');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'code': code,
        'newPassword': newPassword,
      }),
    );
  }
}
