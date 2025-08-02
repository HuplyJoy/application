import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        context.go('/login');
      } else {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/splash_cover/cover.jpg', fit: BoxFit.cover,),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 80 ),
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              height: 160,
              width: 160,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('assets/huply_joi.png', fit: BoxFit.cover,),
            ),
          ),
        ],
      )
    );
  }
}