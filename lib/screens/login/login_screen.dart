import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/sign_up/sign_up_screen.dart';

// 내가 작성한 코드
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
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
              'Log in for TikTok',
              style: TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v20,
            Text(
              'Manage your account, check notification, comment on videos, and more.',
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
              "Don't have an account?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.h10,
            GestureDetector(
              onTap: () => onSignUpTap(context),
              child: Text(
                "Sign Up",
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
