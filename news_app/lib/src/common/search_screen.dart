import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/src/videoplayer_screen/video_player.dart';

import '../models/news_model.dart';
import '../screens/blog/widgets/show_blog_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.list});

  final List<NewsElement> list;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<NewsElement> _filteredNewsList = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _filterNews(query);
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredNewsList.addAll(widget.list);
  }

  void _filterNews(String query) {
    if (query.isEmpty) {
      _filteredNewsList = List.from(widget.list);
    } else {
      _filteredNewsList = widget.list
          .where(
              (news) => news.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: TextField(
              autofocus: true,
              cursorHeight: 25,
              controller: _searchController,
              onChanged: (query) {
                _onSearchChanged(query);
              },
              decoration: InputDecoration(
                  focusColor: Colors.red,
                  contentPadding: const EdgeInsets.symmetric(vertical: 1),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search News",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 10,
            child: ListView.builder(
              itemCount:
                  _filteredNewsList.isNotEmpty ? _filteredNewsList.length : 1,
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _filteredNewsList.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            _filteredNewsList[index].videoUrl != null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayVideoScreen(
                                          videoUrl: _filteredNewsList[index]
                                              .videoUrl
                                              .toString(),
                                          views: _filteredNewsList[index]
                                              .views
                                              .toString()),
                                    ))
                                : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HTMLWidget(
                                      img: _filteredNewsList[index]
                                          .coverPhoto
                                          .toString(),
                                      htmlContent: _filteredNewsList[index]
                                          .description
                                          .toString(), title: _filteredNewsList[index].title.toString(),),
                                ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            child: _filteredNewsList.isNotEmpty
                                ? _filteredNewsList[index].coverPhoto != null
                                    ? Image.network(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        _filteredNewsList[index].coverPhoto!,
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
                                      )
                                : const Image(
                                    image: AssetImage(
                                        "assets/image/ezgif.com-crop.gif"),
                                  ),
                          ))
                      : Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 1.7,
                              width: MediaQuery.of(context).size.width,
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    "assets/image/ezgif.com-crop.gif"),
                              ),
                            ),
                          ],
                        ),
                  Text(
                    _filteredNewsList.isNotEmpty
                        ? _filteredNewsList[index].title.toString()
                        : "",
                    style: const TextStyle(
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
