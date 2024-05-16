import 'package:flutter/material.dart';
class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.title, required this.value});
final String title;
final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17
        ),
        children: [
          TextSpan(
            text: value,
            style:  TextStyle(
              color: Colors.blueAccent.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

