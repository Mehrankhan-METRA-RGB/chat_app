import 'package:flutter/material.dart';

class TileText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLine;
  const TileText(
    this.text, {
    super.key,
    required this.style,
    this.overflow,
    this.maxLine,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style,
    );
  }
}
