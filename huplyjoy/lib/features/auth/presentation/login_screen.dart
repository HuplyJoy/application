import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huplyjoi/core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();
  bool loading = false;

  void login() async {
    setState(() => loading = true);
    try {
      await auth.signInWithEmail(emailCtrl.text.trim(), passCtrl.text.trim());
      context.go('/home');
    } catch (e) {
      showError(e.toString());
    }
    setState(() => loading = false);
  }

  void googleLogin() async {
    setState(() => loading = true);
    try {
      await auth.signInWithGoogle();
      context.go('/home');
    } catch (e) {
      showError(e.toString());
    }
    setState(() => loading = false);
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("تسجيل الدخول", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "البريد الإلكتروني")),
            const SizedBox(height: 10),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: "كلمة المرور"), obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: login, child: const Text("تسجيل الدخول")),
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text("إنشاء حساب جديد"),
            ),
            const SizedBox(height: 20),
            IconButton.filled(
              onPressed: googleLogin,
              icon: const Icon(Icons.g_mobiledata, size: 30,),
            ),
          ],
        ),
      ),
    );
  }
}