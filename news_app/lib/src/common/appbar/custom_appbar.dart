// import 'package:flutter/material.dart';
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key, required this.title,  this.leadingIcon, required this.actionIcon, required this.showLeadingIcon,
//   });
// final String title;
// final IconData? leadingIcon;
// final IconData actionIcon;
// final _searchController =TextEditingController();
// final bool showLeadingIcon;
//  VoidCallback onChange;
//   @override
//   Widget build(BuildContext context) {
//     return  AppBar(
//     backgroundColor: Colors.blueAccent.shade100,
//     centerTitle: false,
//     title: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: SizedBox(
//     height: 60,
//     width: MediaQuery.of(context).size.width,
//     child: TextField(
//     controller: _searchController,
//     onChanged: onChange,
//     decoration: InputDecoration(
//     filled: true,
//     hintText: "Search News",
//     prefixIcon: const Icon(Icons.search),
//     border: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10))),
//     ),
//     ),
//     ),
//     ),
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(56);
// }
