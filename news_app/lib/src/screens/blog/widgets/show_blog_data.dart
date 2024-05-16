import 'package:flutter/material.dart';
import 'package:html/parser.dart';
class HTMLWidget extends StatelessWidget {
  HTMLWidget({required this.htmlContent, required this.img});
  final String htmlContent;
  final String img;
  @override
  Widget build(BuildContext context) {
    String description=parse(htmlContent).documentElement!.text;
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(children: [
          Image(image: AssetImage(img)),
      Center(child: Text(description.toString()),)
        ],)
      ),
    );
  }
}
