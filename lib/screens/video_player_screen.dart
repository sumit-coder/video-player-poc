import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key, required this.videoUri, required this.videoTitle})
      : super(key: key);

  final String videoUri;
  final String videoTitle;

  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  ChewieController? chewieController;
  late VideoPlayerController videoPlayerController;

  Widget? VideoPlayer;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUri);

    videoPlayerController.initialize().then(
      (value) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
          aspectRatio: videoPlayerController.value.aspectRatio,
          showOptions: false,
        );

        setState(() {
          VideoPlayer = Chewie(
            controller: chewieController!,
          );
        });
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade200),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 800,
          color: Colors.blue.shade300,
          // if Video player ready then show it else show CircularProgressIndicator
          child: VideoPlayer != null
              ? Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        // height: 230,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            widget.videoTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
