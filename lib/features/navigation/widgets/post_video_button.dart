import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    super.key,
    required this.isPressed,
  });

  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: Sizes.size20,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 100,
            ),
            height: Sizes.size28 + Sizes.size2,
            width: Sizes.size24 + Sizes.size1,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: isPressed ? Theme.of(context).primaryColor : Colors.blue,
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        Positioned(
          left: Sizes.size20,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: Sizes.size28 + Sizes.size2,
            width: Sizes.size24 + Sizes.size1,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: isPressed ? Colors.blue : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: isPressed ? 0.6 : 1,
          duration: const Duration(
            milliseconds: 100,
          ),
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Sizes.size6,
              ),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
