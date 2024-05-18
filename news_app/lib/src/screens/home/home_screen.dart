

import 'package:flutter/material.dart';
import 'package:news_app/src/videoplayer_screen/video_player.dart';

import '../../common/text_widgets/heading_text.dart';
import '../../models/news_model.dart';
import '../blog/widgets/show_blog_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.list});

  final List<NewsElement> list;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<NewsElement> _filteredNewsList = [];
  // TextEditingController _searchController = TextEditingController();
  // Timer? _debounce;

  // void _onSearchChanged() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 300), () {
  //     _filterNews(_searchController.text);
  //   });
  // }
  // //
  // // @override
  // // void initState() {
  // //   // TODO: implement initState
  // //   super.initState();
  // //   _filteredNewsList.addAll(widget.list);
  // // }
  //
  // void _filterNews(String query) {
  //   if (query.isEmpty) {
  //     _filteredNewsList = List.from(widget.list);
  //   } else {
  //     _filteredNewsList = widget.list
  //         .where((news) =>
  //             news.title.toLowerCase().contains(query.toLowerCase()) ||
  //             news.description!.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blueAccent.shade100,
      //   centerTitle: true,
      //   title: Text(
      //     "Daily News",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   leading: Image(
      //     image: AssetImage("assets/image/logo.gif"),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //       child: IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Icons.search,
      //             color: Colors.black,
      //             size: 35,
      //           )),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
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
                                    videoUrl:
                                        widget.list[index].videoUrl.toString(),
                                    views: widget.list[index].views.toString()),
                              ))
                          :  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HTMLWidget(
                                img: widget.list[index]
                                    .coverPhoto
                                    .toString(),
                                htmlContent: widget.list[index]
                                    .description
                                    .toString(), title:widget.list[index].title,),
                          ));
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: widget.list.isNotEmpty
                            ? widget.list[index].coverPhoto != null
                                ? Image.network(
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    widget.list[index].coverPhoto!,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/image/img.png",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    "assets/image/img_1.png",
                                    fit: BoxFit.cover,
                                  )
                            : const CircularProgressIndicator()),
                  ),
                  Text(
                    widget.list.isNotEmpty
                        ? widget.list[index].title.toString()
                        : "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),  HeadingText(title: "Views", value:    widget.list.isNotEmpty? widget.list[index].views.toString():"",
                  ),
                  const SizedBox(height: 4,),
                  HeadingText(
                      title: "Created at",
                      value: widget.list[index].createdAt
                          .toLocal()
                          .toString()),
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
        height: 20,
      );
}
