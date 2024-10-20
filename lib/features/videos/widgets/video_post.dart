import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  // final Function onVideoFinished;

  final int index;

  const VideoPost({
    super.key,
    // required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;

  late AnimationController _animationController;

  final Duration _animationDuration = const Duration(milliseconds: 250);

  bool _isPaused = false;
  bool _captionVisible = false;

  final String _inputCaption = "#Flutter #Challenge #NomadCoders";

  // void _onVideoChange() {
  //   if (_videoPlayerController.value.isInitialized) {
  //     if (_videoPlayerController.value.duration ==
  //         _videoPlayerController.value.position) {
  //       // widget.onVideoFinished();
  //     }
  //   }
  // }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/test_video.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    // _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    //유저가 scroll로 화면을 일부만 끌어올리면 재생되지 않고, 완전히 전환하면 재생됨
    if (info.visibleFraction == 1 &&
        //pause하고 새로고침하면, 2자기 조건식을 모두 만족해서 pause된 상태로 재생되는 문제가 발생 => !_isPaused라는 조건식 추가
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    //동영상이 재생중이고, 동영상이 전혀 안보이는 상태라면 즉 homeTap을 벗어났다면 pause
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onToggleCaption() {
    setState(() {
      _captionVisible = !_captionVisible;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      //BottomSheet의 background를 transparent로 설정해주어야 VideoComments에서 borderRadius적용한 걸 시각화 해서 볼 수 있음
      backgroundColor: Colors.transparent,
      //bottomsheet의 크기를 변경 가능하게 해주는 옵션
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );

    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            //Positione은 언제나 Stack의 child여야 하기 때문에, IgnorePointer가 Center를 감싸줌.
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  //builder는 _animationController의 값이 변할 때 마다 실행
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      //child는 AnimatedBuilder의 child를 가리킨다.
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@니코",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                const Text(
                  "This is my test video in ios simulator!!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      _captionVisible
                          ? _inputCaption
                          : _inputCaption.substring(0, 20),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    Gaps.h10,
                    GestureDetector(
                      onTap: _onToggleCaption,
                      child: Text(
                        _captionVisible ? "Close" : "... See more",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/135118163?v=4",
                  ),
                  child: Text("User"),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: '2.9M',
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: '33.0K',
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: 'Share',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
