import 'package:flutter/material.dart';
import 'package:news_app/src/videoplayer_screen/video_player.dart';

import '../../models/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.list});

  final List<NewsElement> list;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:   AppBar(
      backgroundColor: Colors.blueAccent.shade100,
      centerTitle: true,
      title: Text(
        "Daily News",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      leading:Image(image: AssetImage("assets/image/logo.gif"),),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 35,
              )),
        )
      ],
    ),
      body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 2),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height-150,
                  child: ListView.builder(
                    itemCount: widget.list.isNotEmpty ? widget.list.length : 1,
                    itemBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("No News Video Available"),
                                        duration: Duration(milliseconds: 400)));
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              child:widget.list.isNotEmpty?  widget.list[index].coverPhoto != null
                                  ? Image.network(
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
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
                                    ):CircularProgressIndicator()),
                        ),
                        Text(
                          widget.list.isNotEmpty? widget.list[index].title.toString():"",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        _space,
                        _space
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget get _space => const SizedBox(
        height: 10,
      );
}
