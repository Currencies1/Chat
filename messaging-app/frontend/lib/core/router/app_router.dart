import 'package:flutter/material.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/phone_input_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/auth/screens/profile_setup_screen.dart';
import '../../features/chat/screens/home_screen.dart';
import '../../features/chat/screens/chat_detail_screen.dart';
import '../../features/calls/screens/calls_screen.dart';
import '../../features/status/screens/status_screen.dart';
import '../../features/groups/screens/groups_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String phoneInput = '/phone-input';
  static const String otpVerification = '/otp-verification';
  static const String profileSetup = '/profile-setup';
  static const String home = '/home';
  static const String chatDetail = '/chat-detail';
  static const String calls = '/calls';
  static const String status = '/status';
  static const String groups = '/groups';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case phoneInput:
        return MaterialPageRoute(builder: (_) => const PhoneInputScreen());
      case otpVerification:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(phoneNumber: args['phone']),
        );
      case profileSetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case chatDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChatDetailScreen(
            chatId: args['chatId'],
            userName: args['userName'],
            userImage: args['userImage'],
          ),
        );
      case calls:
        return MaterialPageRoute(builder: (_) => const CallsScreen());
      case status:
        return MaterialPageRoute(builder: (_) => const StatusScreen());
      case groups:
        return MaterialPageRoute(builder: (_) => const GroupsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('الصفحة غير موجودة: ${settings.name}')),
          ),
        );
    }
  }
}
