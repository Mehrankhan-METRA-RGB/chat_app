import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage(
      {required this.height,
      this.radius = 0,
      required this.width,
      required this.errorImageUrl,
      required this.url,
      this.topRadius,
      this.bottomRadius,
      this.fit = BoxFit.fill,
      Key? key})
      : super(key: key);
  final String url;
  final String errorImageUrl;
  final double width;
  final double height;
  final double radius;
  final double? bottomRadius;
  final double? topRadius;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRadius ?? radius),
          topLeft: Radius.circular(topRadius ?? radius),
          bottomLeft: Radius.circular(bottomRadius ?? radius),
          bottomRight: Radius.circular(bottomRadius ?? radius)),
      child: CachedNetworkImage(
        imageUrl: url,
        errorWidget: (context, url, error) => Image(
            width: width,
            height: height,
            fit: fit,
            image: AssetImage(errorImageUrl)),
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          fit: fit,
          width: width,
          height: height,
        ),
        placeholder: (context, url) => SizedBox(
          width: width,
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 10,
              backgroundColor: Colors.blueAccent.withOpacity(0.4),
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
