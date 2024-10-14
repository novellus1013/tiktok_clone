import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onSubmitTap() {
    //validator에 에러가 없다면 true를 반환.
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        //save는 모든 텍스트 입력에 onSave 함수를 실행
        _formKey.currentState!.save();
        print(formData);
      }
    }
  }

  bool _emailValidator(String? value) {
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return regExp.hasMatch(value!) ? true : false;
  }

  bool _passwordValidator(String? value) {
    final regExp = RegExp(
        r"^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*#?&\^])[A-Za-z0-9@$!%*#?&\^]+$");
    return regExp.hasMatch(value!) ? true : false;
  }

  Map<String, String> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        //반드시 key 값을 추가해 주어야 currentState가 변경됨
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  return _emailValidator(value) ? null : "Email not valid";
                },
                //저장된 순간의 입력값 = newValue;
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                validator: (value) {
                  return _passwordValidator(value)
                      ? null
                      : "Password not valid";
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['password'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: const FormButton(
                  disabled: false,
                  buttonText: 'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
