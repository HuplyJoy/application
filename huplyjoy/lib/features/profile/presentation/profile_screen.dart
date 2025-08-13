import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:huplyjoi/app/theme/theme_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final points = '1200';

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
                  //   await  FirebaseAuth.instance.currentUser.up(user, emailCtrl.text);
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

  void _changTheme(value) {
    setState(() {
      ref.read(themeModeProvider.notifier).changThemeMode(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

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
          SwitchListTile(
            value: isDark,
            title: Row(
              children: [
                Icon(isDark?Icons.dark_mode:Icons.sunny),
                const SizedBox(width: 16,),
                Text(isDark?'الوضع الليلي':'الوضع النهاري'),
              ],
            ),
            onChanged: _changTheme,
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
