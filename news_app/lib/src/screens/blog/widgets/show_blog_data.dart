import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class HTMLWidget extends StatelessWidget {
  const HTMLWidget(
      {super.key,
      required this.htmlContent,
      required this.img,
      required this.title});

  final String htmlContent;
  final String title;
  final String img;

  @override
  Widget build(BuildContext context) {
    String description = parse(htmlContent).documentElement!.text;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blueAccent.shade100,
        title: const Text(
          "Daily News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: img != null
                  ? Image.network(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2,
                      img,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/image/img_1.png",
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      "assets/image/img_1.png",
                      fit: BoxFit.cover,
                    )),

          const SizedBox(
            height: 10,
          ),
          Text(
            title.toString(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(
            height: 5,
          ),
          Text(description.toString())
        ],
      )),
    );
  }
}
