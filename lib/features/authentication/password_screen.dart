import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  //위젯이 처음 생성될 때 1회만 실행
  void initState() {
    super.initState();

    // addListener는 _usernameController.text 값이 변경될 때 마다 콜백 함수를 트리거 -> setState를 호출
    _passwordController.addListener(
      () {
        setState(() {
          _password = _passwordController.text;
        });
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordLengthValid() {
    // final regExp = RegExp(r"^.{8,20}$");
    // return regExp.hasMatch(_password);

    return _password.isNotEmpty &&
        _password.length >= 8 &&
        _password.length <= 20;
  }

  bool _isPasswordContainsSpecialChar() {
    final regExp = RegExp(
        r"^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*#?&\^])[A-Za-z0-9@$!%*#?&\^]+$");
    return regExp.hasMatch(_password);
  }

  //scaffold 클릭 시 텍스트 필드 포커스 제거
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordLengthValid() || !_isPasswordContainsSpecialChar()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  // 바뀌는 값을 모두 setState에 넣어줄 필요 없음 => setState만 따로 호출
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              //입력창이 여러개인 form 에서는 TextField 보다 좀 더 validation을 강화할 수 있는 다른 위젯 사용
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                // done을 누를 때 실행되는 프로퍼티
                onEditingComplete: () => _onSubmit,
                //password 암호화
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: "Make it strong!",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordLengthValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h10,
                  const Text('8 to 20 characters'),
                ],
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordContainsSpecialChar()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h10,
                  const Text(
                    "Letters, numbers, and special characters",
                  ),
                ],
              ),
              Gaps.v28,
              //FormButton에서는 username이 뭔지 알 필요가 없고, username이 empty인지 아닌지만 알면 됨.
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_isPasswordLengthValid() ||
                      !_isPasswordContainsSpecialChar(),
                  buttonText: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
