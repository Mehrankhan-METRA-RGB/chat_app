import 'dart:io';

import 'package:chat_app/Application/Chat/chat_cubit.dart';
import 'package:chat_app/Domain/Models/message_model.dart';
import 'package:chat_app/Presentation/common/app_bar.dart';
import 'package:chat_app/Presentation/common/app_shadow.dart';
import 'package:chat_app/Presentation/common/app_text_field.dart';
import 'package:chat_app/Presentation/views/Chat/Components/tile_images.dart';
import 'package:chat_app/Presentation/views/Chat/audio_player.dart';
import 'package:chat_app/Presentation/views/Chat/chat_tile.dart';
import 'package:chat_app/Presentation/views/Chat/record_audio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.myId, Key? key}) : super(key: key);
  final String myId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textCont = TextEditingController();
  List<String> temporaryFiles = [];
  File? imageFile;
  String? voice;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? pickedImages = [];
  @override
  void initState() {
    // TODO: implement initState
    context.read<ChatCubit>().initialLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'User ${widget.myId} Chat Screen',
        isLeading: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ChatLoadedState) {
                    if (state.messages!.isNotEmpty) {
                      return ListView.builder(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.messages!.length,
                          itemBuilder: (context, index) => state
                                  .messages![index].url!.isNotEmpty
                              ? state.messages![index].url![0]
                                          .split('.')
                                          .last ==
                                      'm4a'
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child:
                                      // Container()
                                      AppAudioPlayer(
                                        path: state.messages![index].url![0],
                                        messageId: state.messages![index].id!,
                                        myId: widget.myId,
                                      ),
                                      )
                                  : ChatTile(
                                      data: state.messages![index],
                                      id: widget.myId,
                                    )
                              : ChatTile(
                                  data: state.messages![index],
                                  id: widget.myId,
                                )
                          // ChatTile(id: '$index', data: MessageModel())

                          );
                    } else {
                      return const Center(
                        child: Text(
                          'No Chat Yet!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                        color: Colors.blueAccent.shade200,
                        strokeWidth: 5,
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [AppShadow.normal()],
                color: Colors.white,
              ),
              child: Column(
                children: [
                  temporaryFiles.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TileImages(
                            imagePaths: temporaryFiles,
                            isNotChatTile: true,
                            callBack: (data) {
                              setState(() {
                                temporaryFiles = data;
                              });
                            },
                          ),
                        )
                      : Container(),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.file_present,
                                color: Colors.black26,
                                size: 20,
                              ),
                              onPressed: () => pickFiles(),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.keyboard_voice_sharp,
                                color: Colors.black26,
                                size: 20,
                              ),
                              onPressed: () {
                                _showModalSheet();
                              },
                            ),
                            controller: textCont,
                            maxline: null,
                            hintText: 'Write Here',
                            textInputType: TextInputType.multiline),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.black26,
                          size: 25,
                        ),
                        onPressed: () {
                          textCont.text.isNotEmpty || temporaryFiles.isNotEmpty
                              ? context.read<ChatCubit>().sendMessage(
                                  MessageModel(
                                      id: widget.myId,
                                      text: textCont.text,
                                      url: temporaryFiles,
                                      status: true,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now()))
                              : null;
                          setState(() {
                            textCont.clear();
                            temporaryFiles = [];
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return AudioRecorder(onStop: (path) {
            context.read<ChatCubit>().sendMessage(MessageModel(
                id: widget.myId,
                url: [path],
                status: true,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now()));
            Navigator.pop(context);
            print(temporaryFiles);
          });
        });
  }

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      // allowedExtensions: ['jpg','','docx', 'doc', 'pdf', 'csv', 'xls', 'xlsx', 'txt']
    );
    temporaryFiles = [];

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      if (files.length + temporaryFiles.length < 10) {
        setState(() {
          temporaryFiles.addAll(files.map((e) => e.path).toList());
        });
      }
    } else {
      // User canceled the picker
    }
  }
}
