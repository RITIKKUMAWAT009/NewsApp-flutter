import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/common/text_widgets/heading_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen(
      {super.key, required this.videoUrl, required this.views});

  final String videoUrl;
  final String views;

  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  final String _ids = 'M-VWY9dCNM0';
  String? videoIdd;

  void getYouId() {
    try {
      videoIdd = YoutubePlayer.convertUrlToId(widget.videoUrl);
      log('this is ${videoIdd!}');
    } catch (error) {
      log('error$error');
    }
  }

  @override
  void initState() {
    super.initState();
    getYouId();
    _controller = YoutubePlayerController(
      initialVideoId: videoIdd!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        // onEnded: (data) {
        //   _controller
        //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
        //   _showSnackBar('Next Video Started!');
        // },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
         backgroundColor:  Colors.blueAccent.shade100,
          automaticallyImplyLeading: true,
          surfaceTintColor: Colors.black,
          title: const Text(
            'Video',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.video_library),
            //   onPressed: () => Navigator.push(
            //     context,
            //     CupertinoPageRoute(
            //       builder: (context) => Text("data"),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  HeadingText(title: "Views", value: widget.views),
                  _space,
                  HeadingText(title: 'Title', value: _videoMetaData.title),
                  _space,
                  HeadingText(title: 'Channel', value: _videoMetaData.author),
                  _space,
                  HeadingText(title: 'Video Id', value: _videoMetaData.videoId),
                  _space,
                  Row(
                    children: [
                      HeadingText(
                        title: 'Playback Quality',
                        value: _controller.value.playbackQuality ?? '',
                      ),
                      const Spacer(),
                      HeadingText(
                        title: 'Playback Rate',
                        value: '${_controller.value.playbackRate}x  ',
                      ),
                    ],
                  ),
                  _space,
                  Row(
                    children: <Widget>[
                      const Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                                  setState(() {
                                    _volume = value;
                                  });
                                  _controller.setVolume(_volume.round());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  _space,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _getStateColor(_playerState),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Video is : ' + _playerState.name.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

// Widget _loadCueButton(String action) {
//   return Expanded(
//     child: MaterialButton(
//       color: Colors.blueAccent,
//       onPressed: _isPlayerReady
//           ? () {
//         if (_idController.text.isNotEmpty) {
//           var id = YoutubePlayer.convertUrlToId(
//             _idController.text,
//           ) ??
//               '';
//           if (action == 'LOAD') _controller.load(id);
//           if (action == 'CUE') _controller.cue(id);
//           FocusScope.of(context).requestFocus(FocusNode());
//         } else {
//           _showSnackBar('Source can\'t be empty!');
//         }
//       }
//           : null,
//       disabledColor: Colors.grey,
//       disabledTextColor: Colors.black,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14.0),
//         child: Text(
//           action,
//           style: const TextStyle(
//             fontSize: 18.0,
//             color: Colors.white,
//             fontWeight: FontWeight.w300,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//   );
// }
//
// void _showSnackBar(String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontWeight: FontWeight.w300,
//           fontSize: 16.0,
//         ),
//       ),
//       backgroundColor: Colors.blueAccent,
//       behavior: SnackBarBehavior.floating,
//       elevation: 1.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(50.0),
//       ),
//     ),
//   );
// }
}
