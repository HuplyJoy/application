import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huplyjoi/core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _repass = TextEditingController();

  final _name = TextEditingController();
  final _auth = AuthService();
  final _formKey = GlobalKey();
  bool _loading = false;
  bool _isLogin = true;

  void _register() async {
    if (_pass.text.trim() != _repass.text.trim()) {
      _showError("Passwords do not match.");
      return;
    }

    setState(() => _loading = true);

    try {
      final result =await _auth.registerWithEmail(
        _email.text.trim(),
        _pass.text.trim(),
      );
      if(result.user != null){
        await result.user!.updateDisplayName(_name.text.trim());
        await result.user!.reload();
      }
      context.go('/home');
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  void _login() async {
    setState(() => _loading = true);
    try {
      await _auth.signInWithEmail(
        _email.text.trim(),
        _pass.text.trim(),
      );
      context.go('/home');
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  void _googleLogin() async {
    setState(() => _loading = true);
    try {
      await _auth.signInWithGoogle();
      context.go('/home');
    } catch (e) {
      _showError(e.toString());
    }
    setState(() => _loading = false);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_cover/cover.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:
            _loading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black87,
                    ),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/huply_joi.png',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              _isLogin ? "تسجيل دخول" : "إنشاء حساب",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            if (!_isLogin)
                              TextFormField(
                                controller: _name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "اسم المستخدم",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            SizedBox(height: 12),
                            TextFormField(
                              controller: _email,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "البريد الإلكتروني",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              controller: _pass,
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "كلمة المرور",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12,
                                ),
                              ),
                            ),
                            if (!_isLogin) SizedBox(height: 12),
                            if (!_isLogin) TextFormField(
                                controller: _repass,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "اعادة كلمة المرور",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: _isLogin ? _login : _register,
                              child: Text(
                                _isLogin ? "دخول" : "إنشاء",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin ? "إنشاء حساب" : "تسجيل دخول",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 12),
                            if (_isLogin)
                              IconButton.filled(
                                onPressed: _googleLogin,
                                icon: Icon(Icons.g_mobiledata, size: 24),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
