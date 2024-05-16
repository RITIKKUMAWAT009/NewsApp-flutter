import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key, required this.title,  this.leadingIcon, required this.actionIcon, required this.showLeadingIcon,
  });
final String title;
final IconData? leadingIcon;
final IconData actionIcon;
final bool showLeadingIcon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent.shade100,
centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

     leading:showLeadingIcon? IconButton(onPressed: (){},icon:Icon(leadingIcon),):SizedBox(width: 0,),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                actionIcon,
                color: Colors.black,
                size: 35,
              )),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
