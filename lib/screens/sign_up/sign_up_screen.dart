import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/login/login_screen.dart';

// 내가 작성한 코드
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          children: [
            Text(
              'Sign up for TikTok',
              style: TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v20,
            Text(
              'Crate a profile, follow other accounts, make your own videos, and more.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Already have an account?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.h10,
            GestureDetector(
              onTap: () => onLoginTap(context),
              child: Text(
                'Log in',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
