import 'package:go_router/go_router.dart';
import 'package:huplyjoi/features/auth/presentation/login_screen.dart';
import 'package:huplyjoi/features/auth/presentation/register_screen.dart';
import 'package:huplyjoi/features/home/presentation/home_screen.dart';
import 'package:huplyjoi/features/profile/presentation/profile_screen.dart';
import 'package:huplyjoi/features/onboarding/presentation/onboarding_screen.dart';
import 'package:huplyjoi/features/splash/presentation/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
