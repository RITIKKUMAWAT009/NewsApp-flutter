import 'package:flutter/material.dart';
import 'package:news_app/src/common/text_widgets/heading_text.dart';
import 'package:news_app/src/models/news_model.dart';
import 'package:news_app/src/screens/blog/widgets/show_blog_data.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key, required this.blogNews});

  final List<NewsElement> blogNews;

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widget.blogNews.isEmpty || widget.blogNews == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemCount:
                      widget.blogNews.isNotEmpty ? widget.blogNews.length : 1,
                  itemBuilder: (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.blogNews[index].description != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          // PlayVideoScreen(
                                          //     videoUrl: widget
                                          //         .blogNews[index].videoUrl
                                          //         .toString(),
                                          //     views: widget.blogNews[index].views
                                          //         .toString())
                                          HTMLWidget(
                                            htmlContent: widget
                                                .blogNews[index].description
                                                .toString(),
                                            img: widget.blogNews[index]
                                                        .coverPhoto !=
                                                    null
                                                ? widget
                                                    .blogNews[index].coverPhoto
                                                    .toString()
                                                : "assets/image/img.png", title: widget.blogNews[index].title,
                                          )))
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No News Video"),
                                      duration: Duration(milliseconds: 500)));
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            child: widget.blogNews[index].file != null
                                ? Image.network(
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    widget.blogNews[index].file!,
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
                                  )),
                      ),
                      _space,
                      Text(
                        widget.blogNews[index].title.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      HeadingText(title: "Views", value: widget.blogNews[index].views.toString(),
                      ),
                      _space,
                      HeadingText(
                          title: "Blog Created at",
                          value: widget.blogNews[index].createdAt
                              .toLocal()
                              .toString()),
                     const SizedBox(height: 25,)
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget get _space => const SizedBox(height: 5);
}
