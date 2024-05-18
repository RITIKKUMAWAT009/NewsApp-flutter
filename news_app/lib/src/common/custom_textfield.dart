import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget implements PreferredSizeWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
          decoration: InputDecoration(filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        hintText: "Search News",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )),
    );
  }
}
