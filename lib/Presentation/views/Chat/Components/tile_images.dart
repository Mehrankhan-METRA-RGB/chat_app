import 'dart:io';

import 'package:flutter/material.dart';

class TileImages extends StatefulWidget {
  const TileImages(
      {this.imagePaths, this.callBack, this.isNotChatTile = false, Key? key})
      : super(key: key);
  final List<String>? imagePaths;
  final void Function(List<String> paths)? callBack;
  final bool isNotChatTile;
  @override
  State<TileImages> createState() => _TileImagesState();
}

class _TileImagesState extends State<TileImages> {
  List<String>? tempPaths = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNotChatTile) tempPaths = widget.imagePaths;

    return widget.isNotChatTile
        ? _gridView(tempPaths!, crossAxisCount: 4)
        : widget.imagePaths!.length > 1
            ? _gridView(widget.imagePaths!)
            : widget.imagePaths!.length == 1
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _image(widget.imagePaths![0]),
                  )
                : Container();
  }

  _gridView(List<String> paths, {int crossAxisCount = 2}) => GridView.count(
        primary: false,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
        shrinkWrap: true,
        children: List.generate(
          paths.length,
          (index) {
            return widget.isNotChatTile
                ? Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _image(paths[index])),
                      Positioned(
                        top: -12,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            if (tempPaths!.isNotEmpty) {
                              tempPaths!.removeAt(index);
                            }
                            var fun = widget.callBack;
                            if (fun != null) {
                              fun(tempPaths!);
                            }
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent,
                            ),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _image(widget.imagePaths![index]));
          },
        ),
      );

  ClipRRect _image(String path) {
    List<String> allDocsType = [
      'docx',
      'pptx',
      'pdf',
      'xls',
      'doc',
      'html',
      'csv',
      'zip',
      'rar',
      'txt',
      'ppt',
    ];
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: allDocsType.contains(path.split('.').last)
            ? Image.asset(
                'assets/icons/docs.png',
                fit: BoxFit.cover,
              )
            : Image.file(
                File(path),
                fit: BoxFit.cover,
              ));
  }
}
