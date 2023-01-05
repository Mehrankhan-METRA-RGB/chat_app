import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color? iconColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? horizontalMargin;
  final double? verticalMargin;

  ///must be Icon Data
  final IconData? trailingIcon;

  ///must be Icon Data
  final IconData? leadingIcon;
  final double? imageWidth;
  final double? imageHeight;
  final bool isBorder;
  const AppButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.bgColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.horizontalPadding = 20,
    this.verticalPadding = 18,
    this.horizontalMargin = 1,
    this.verticalMargin = 1,
    this.trailingIcon,
    this.iconColor,
    this.isBorder = true,
    this.leadingIcon,
    this.imageWidth = 22,
    this.imageHeight = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin!,
          vertical: verticalMargin!,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding!,
          vertical: verticalPadding!,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: isBorder
              ? Border.all(
                  color: Colors.blueAccent,
                  width: 1,
                )
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        leadingIcon,
                        color: iconColor,
                        size: imageWidth,
                      ),
                    )
                  : Container(),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: 16,
                ),
              ),
              trailingIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        trailingIcon,
                        color: iconColor,
                        size: imageWidth,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
