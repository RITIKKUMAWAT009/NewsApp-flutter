import 'package:flutter/material.dart';
import 'package:news_app/src/videoplayer_screen/video_player.dart';

import '../../common/appbar/custom_appbar.dart';
import '../../models/news_model.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.list});

  final List<NewsElement> list;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // List<NewsElement> list = [];
  // List<NewsElement> blogs = [];
  // List<NewsElement> videos = [];
  // @override
  // void initState() {
  //   super.initState();
  //   _getNews();
  // }
  //
  // _getNews() async {
  //   list = (await ApiService().getNewsData())!;
  //   print('list count: ${list.length}');
  //
  //   Future.delayed(
  //     const Duration(seconds: 2),
  //     () => setState(() {
  //       videos = list.where((news) => news.newsType== NewsType.VIDEO_NEWS).toList();
  //       blogs = list.where((news) => news.newsType == NewsType.BLOG).toList();
  //       print('Blogs count: ${blogs.length}'); // Debugging line
  //       print('Videos count: ${videos.length}'); // D
  //     }),
  //   );
  //   // print(list[8].title);
  //   // print(list[4].description);
  //   for(int i=0;i<list.length;i++){
  //     print(list[i].userId);
  //   }
  //   // print('Blogs count: ${blogs.length}'); // Debugging line
  //   // print('Videos count: ${videos.length}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Videos",actionIcon: Icons.search,leadingIcon: Icons.arrow_back,showLeadingIcon: true,),

      body: widget.list.isEmpty || widget.list == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 2),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 170,
                  child: ListView.builder(
                    itemCount: widget.list.isNotEmpty ? widget.list.length : 1,
                    itemBuilder: (context, index) => Column(
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
                                    .showSnackBar(SnackBar(
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
                                        width: MediaQuery.of(context).size.width,
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
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
