import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  //화면이 stack으로 쌓이기 때문에 push 하면 pop 필요
  void onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
  }

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
                "Log in to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Manage your account, check notifications, comment on videos, and more.",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: Sizes.size16,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v20,
              AuthButton(
                screen: LoginFormScreen(),
                icon: FaIcon(FontAwesomeIcons.user),
                text: "Use email and password",
              ),
              Gaps.v16,
              // AuthButton(
              //   screen: ,
              //   icon: const FaIcon(
              //     FontAwesomeIcons.facebook,
              //     color: Colors.blue,
              //   ),
              //   text: "Continue with Facebook",
              // ),
              // Gaps.v16,
              // AuthButton(
              //   screen: ,
              //   icon: const FaIcon(FontAwesomeIcons.apple),
              //   text: "Continue with Apple",
              // ),
              // Gaps.v16,
              // AuthButton(
              //   screen: ,
              //   icon: const FaIcon(FontAwesomeIcons.google),
              //   text: "Continue with Google",
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
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
              GestureDetector(
                onTap: () => onSignUpTap(context),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
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
