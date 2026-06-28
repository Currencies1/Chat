import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              // Illustration
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 100,
                  color: Color(0xFF25D366),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'مرحباً بك في مراسل',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'أرسل الرسائل والصور والفيديو والمكالمات\nبشكل آمن ومشفر',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              // Privacy text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'بالضغط على "موافق ومتابعة"، فإنك توافق على '),
                      TextSpan(
                        text: 'شروط الخدمة',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const TextSpan(text: ' و '),
                      TextSpan(
                        text: 'سياسة الخصوصية',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.phoneInput);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'موافق ومتابعة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
