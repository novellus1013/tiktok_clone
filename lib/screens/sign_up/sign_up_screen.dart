import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Sign up for TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Create a profile, follow other accounts, make your own videos, and more.",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: Sizes.size16,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              Gaps.h5,
              Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
