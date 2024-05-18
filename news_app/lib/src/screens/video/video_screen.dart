import 'package:flutter/material.dart';
import 'package:news_app/src/videoplayer_screen/video_player.dart';

import '../../common/text_widgets/heading_text.dart';
import '../../models/news_model.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.list});

  final List<NewsElement> list;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.list.isEmpty || widget.list == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 170,
                  child: ListView.builder(
                    itemCount: widget.list.isNotEmpty ? widget.list.length : 1,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.list[index].videoUrl != null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayVideoScreen(
                                          videoUrl: widget.list[index].videoUrl
                                              .toString(),
                                          views: widget.list[index].views
                                              .toString()),
                                    ))
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text("No News Video"),
                                    duration: Duration(milliseconds: 500),
                                  ));
                          },
                          child: Stack(children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: widget.list[index].coverPhoto != null
                                    ? Image.network(
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        widget.list[index].coverPhoto!,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            "assets/image/img.png",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        "assets/image/img_1.png",
                                        fit: BoxFit.cover,
                                      )),
                            Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                top: 0,
                                child: SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Icon(
                                      Icons.play_circle_filled_sharp,
                                      size: 70,
                                      color: Colors.red.shade900,
                                    )))
                          ]),
                        ),
                        Text(
                          widget.list[index].title.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        HeadingText(
                          title: "Views",
                          value: widget.list[index].views.toString(),
                        ),
                        HeadingText(
                            title: "Blog Created at",
                            value: widget.list[index].createdAt
                                .toLocal()
                                .toString()),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
