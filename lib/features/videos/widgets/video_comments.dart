import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  //showModalBottomSheet은 새 페이지가 push된 것과 같기 때문에 이를 닫아주기 위해서는 pop필요
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size32,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: const Text("22796 comments"),
          //appBar의 leading을 제거해주는 것
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            child: const Text("I am a comment"),
          ),
        ),
      ),
    );
  }
}
