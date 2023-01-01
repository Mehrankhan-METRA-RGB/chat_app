import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/Presentation/common/app_shadow.dart';
import 'package:flutter/material.dart';

class AppAudioPlayer extends StatefulWidget {
  const AppAudioPlayer(
      {Key? key,
      required this.myId,
      required this.messageId,
      required this.path})
      : super(key: key);
  final String path;
  final String messageId;
  final String myId;
  @override
  _AppAudioPlayerState createState() {
    return _AppAudioPlayerState();
  }
}

class _AppAudioPlayerState extends State<AppAudioPlayer> {
  bool _isPlaying = false;
  AudioPlayer? audioPlayer;
  Duration? total;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    getDuration();
    audioPlayer!.getCurrentPosition();
    playAudioFromLocalStorage(DeviceFileSource(widget.path));
    pauseAudio();
  }

  getDuration() async {
    total = await audioPlayer!.getDuration();
  }

  playAudioFromLocalStorage(Source path) async {
    await audioPlayer!.setSource(path);
    // await audioPlayer!.play(
    //   path,
    // );
  }

  pauseAudio() async {
    await audioPlayer!.pause();
  }

  stopAudio() async {
    await audioPlayer!.stop();
  }

  resumeAudio() async {
    await audioPlayer!.resume();
  }

  double? width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width * 0.29;
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 2, top: 5, bottom: 5),
      margin: EdgeInsets.only(
          left: widget.messageId == widget.myId ? width! : 10,
          right: widget.messageId != widget.myId ? width! : 10,
          top: 10,
          bottom: 10),
      decoration: BoxDecoration(
          color: widget.messageId != widget.myId
              ? Colors.blueAccent.shade200
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [AppShadow.normal()]),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: audioPlayer?.onPositionChanged,
              builder: (context, snapshot) {
                final progress = snapshot.data ?? Duration.zero;
                if (snapshot.hasData) {
                  print(snapshot.data!.inSeconds);
                  return StreamBuilder(
                      stream: audioPlayer!.onDurationChanged,
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return ProgressBar(
                            progress: progress,
                            thumbColor: widget.messageId != widget.myId
                                ? Colors.white
                                : null,
                            baseBarColor: widget.messageId != widget.myId
                                ? Colors.white
                                : null,
                            progressBarColor: widget.messageId != widget.myId
                                ? Colors.white
                                : null,
                            timeLabelTextStyle: TextStyle(
                                color: widget.messageId != widget.myId
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 10),
                            timeLabelLocation: TimeLabelLocation.sides,
                            total: snap.data ?? Duration.zero,
                            onSeek: (duration) {
                              setState(() {
                                audioPlayer!.seek(duration);
                              });
                            },
                          );
                        }
                        return ProgressBar(
                          progress: Duration.zero,
                          thumbColor: widget.messageId != widget.myId
                              ? Colors.white
                              : null,
                          baseBarColor: widget.messageId != widget.myId
                              ? Colors.white
                              : null,
                          progressBarColor: widget.messageId != widget.myId
                              ? Colors.white
                              : null,
                          timeLabelTextStyle: TextStyle(
                              color: widget.messageId != widget.myId
                                  ? Colors.white
                                  : Colors.black54,
                              fontSize: 10),
                          timeLabelLocation: TimeLabelLocation.sides,
                          total: Duration.zero,
                          onSeek: (duration) {
                            setState(() {
                              audioPlayer!.seek(duration);
                            });
                          },
                        );
                      });
                }
                return ProgressBar(
                  progress: Duration.zero,
                  thumbColor:
                      widget.messageId != widget.myId ? Colors.white : null,
                  baseBarColor:
                      widget.messageId != widget.myId ? Colors.white : null,
                  progressBarColor:
                      widget.messageId != widget.myId ? Colors.white : null,
                  timeLabelTextStyle: TextStyle(
                      color: widget.messageId != widget.myId
                          ? Colors.white
                          : Colors.black54,
                      fontSize: 10),
                  timeLabelLocation: TimeLabelLocation.sides,
                  total: Duration.zero,
                  onSeek: (duration) {},
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (_isPlaying) {
                pauseAudio();
                setState(() {
                  _isPlaying = false;
                });
              } else {
                resumeAudio();
                setState(() {
                  _isPlaying = true;
                });
              }
            },
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 24,
              color: widget.messageId != widget.myId
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
