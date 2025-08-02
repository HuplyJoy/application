import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم تسجيل الخروج بنجاح')));
      context.go('/login');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    }
  }

  void _setting(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final nameCtrl = TextEditingController(text: user.displayName ?? '');
    final emailCtrl = TextEditingController(text: user.email ?? '');

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("تعديل بيانات الحساب"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "الاسم"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "البريد الإلكتروني",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await user.updateDisplayName(nameCtrl.text);
                  // if (emailCtrl.text != user.email && emailCtrl.text.isNotEmpty) {
                  //   await updateEmail(user, emailCtrl.text);
                  // }
                  await user.reload();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم تحديث البيانات")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("حدث خطأ: $e")));
                }
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final points = '1200';

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: const BorderRadiusDirectional.horizontal(
                start: Radius.circular(8),
              ),
            ),
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => context.go('/home'),
              label: Text(
                '$points XP',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(user?.email ?? 'بلا بريد'),
            subtitle: const Text('تعديل الحساب'),
            trailing: IconButton(
              onPressed: () => _setting(context),
              icon: const Icon(Icons.settings),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('تغيير اللغة'),
            onTap: () {
              // تنفيذ لاحق
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('تبديل الوضع الليلي'),
            onTap: () {
              // تنفيذ لاحق
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
