// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isLeading;
  final Widget? button;
  final Widget? leadingButton;

  const CustomAppBar(
      {key,
      this.button,
      this.leadingButton,
      required this.title,
      this.isLeading = true})
      : preferredSize = const Size.fromHeight(65),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8,
      shadowColor: Colors.black12,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: widget.leadingButton ??
          (widget.isLeading
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.blueAccent,
                    size: 25,
                  ),
                )
              : null),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          widget.title,
          style: const TextStyle(fontSize: 19, color: Colors.black),
        ),
      ),
      actions: [widget.button ?? Container()],
    );
  }
}
