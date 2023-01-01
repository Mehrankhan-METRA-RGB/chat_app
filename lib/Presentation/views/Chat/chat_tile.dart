import 'package:chat_app/Domain/Models/message_model.dart';
import 'package:chat_app/Presentation/common/app_shadow.dart';
import 'package:chat_app/Presentation/views/Chat/Components/tile_images.dart';
import 'package:chat_app/Presentation/views/Chat/Components/tile_text.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key, this.data, this.id}) : super(key: key);
  final MessageModel? data;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          id != data!.id ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: id == data!.id ? Colors.white : Colors.blueAccent.shade100,
            boxShadow: [AppShadow.minimum()],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data!.url!.isNotEmpty
                  ? TileImages(
                      imagePaths: data?.url,
                    )
                  : Container(),
              data!.text != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TileText(data!.text!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    )
                  : Container(),
              Align(
                alignment: id == data!.id
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: TileText(data!.createdAt.toString().split('.').first,
                    style:
                        const TextStyle(fontSize: 11, color: Colors.black26)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
