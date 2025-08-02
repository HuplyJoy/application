import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huplyjoi/core/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();
  bool loading = false;

  void register() async {
    setState(() => loading = true);
    try {
      await auth.registerWithEmail(emailCtrl.text.trim(), passCtrl.text.trim());
      context.go('/home');
    } catch (e) {
      showError(e.toString());
    }
    setState(() => loading = false);
  }

  void googleRegister() async {
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
            const Text("إنشاء حساب", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "البريد الإلكتروني")),
            const SizedBox(height: 10),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: "كلمة المرور"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: register, child: const Text("إنشاء حساب ")),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text("تسجيل دخول"),
            ),
            const SizedBox(height: 10),
            IconButton.filled(
              onPressed: googleRegister,
              icon: const Icon(Icons.g_mobiledata, size: 30,),
            ),
          ],
        ),
      ),
    );
  }
}