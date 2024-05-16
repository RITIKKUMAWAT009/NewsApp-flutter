import 'package:flutter/material.dart';

import '../../models/news_model.dart';
import '../../services/api_service.dart';
import '../blog/blog_screen.dart';
import '../home/home_screen.dart';
import '../video/video_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<NewsElement> allNews = [];
  List<NewsElement> blogs = [];
  List<NewsElement> videos = [];
  bool isCacheLoading = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCachedData();
    _fetchNews();
  }

  void _loadCachedData() async {
    allNews = (await ApiService().getCachedNewsData()) ?? [];
    setState(() {
      blogs = allNews.where((news) => news.newsType == NewsType.BLOG).toList();
      videos = allNews
          .where((news) => news.newsType == NewsType.VIDEO_NEWS)
          .toList();
      isCacheLoading = false;
    });
  }

  void _fetchNews() async {
    setState(() {
      isLoading = true;
    });
    allNews = (await ApiService().getNewsData())!;
    // allNews.add(NewsElement(
    //     id: 1,
    //     title: "Ritik",
    //     slug: "slug",
    //     category: "category",
    //     city: "city",
    //     state: "state",
    //     description: "description",
    //     videoUrl: "https://www.youtube.com/watch?v=Dc5fzzVpNHM",
    //     embedCode: "embedCode",
    //     newsType: NewsType.BLOG,
    //     file: "file",
    //     coverPhoto: "coverPhoto",
    //     metaDescription: "metaDescription",
    //     metaKeywords: "metaKeywords",
    //     userId: "userId",
    //     uniqueKey: "uniqueKey",
    //     status: Status.UNDER_REVIEW,
    //     views: 10,
    //     createdAt: DateTime(DateTime.april),
    //     updatedAt: DateTime(DateTime.april)));

    setState(() {
      blogs = allNews.where((news) => news.newsType == NewsType.BLOG).toList();
      videos = allNews
          .where((news) => news.newsType == NewsType.VIDEO_NEWS)
          .toList();
      isLoading = false;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCacheLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              _getBody(),
              if (isLoading)
                Positioned(
                  left: 0,
                  bottom: MediaQuery.of(context).size.height / 1.38,
                  right: 0,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.red.shade700,
                    backgroundColor: Colors.white,
                    strokeAlign: 3,
                    strokeWidth: 5,
                  )),
                ),
            ]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        selectedLabelStyle: TextStyle(shadows: const [
          // BoxShadow(
          //     color: Colors.blue.shade700, blurRadius: 20, spreadRadius: 20)
        ], color: Colors.blueAccent.shade700, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue.shade100,
        selectedItemColor: Colors.blueAccent.shade700,
        elevation: 5,
        iconSize: 28,
        selectedFontSize: 17,
        unselectedItemColor: Colors.black,

        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Blogs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: 'Videos'),
        ],
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(list: allNews);
      case 1:
        return BlogScreen(blogNews: blogs);
      case 2:
        return VideoScreen(list: videos);
      default:
        return HomeScreen(list: allNews);
    }
  }
}
