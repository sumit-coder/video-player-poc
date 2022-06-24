// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/video_model.dart';
import '../services/api_services.dart';
import 'video_player_screen.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final apiService = ApiService();
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade200),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.blue.shade300,
          child: FutureBuilder(
            future: apiService.getListOfVideos(),
            builder: (BuildContext context, AsyncSnapshot<List<Videos>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoCard(
                      onTap: () {},
                      videoLink: snapshot.data![index].videoUrl,
                      videoTitle: snapshot.data![index].title,
                    );
                  },
                );
              } else if (snapshot.data == []) {
                // api status is other then 200 then this will hit
                return Text('Got error form API');
              } else if (snapshot.hasError) {
                // Future error this will hit
                return Text('Future error');
              } else {
                // when Future is resolving this will hit
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final VoidCallback onTap;
  final String videoLink;
  final String videoTitle;

  const VideoCard({
    super.key,
    required this.onTap,
    required this.videoLink,
    required this.videoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      surfaceTintColor: Colors.white,
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // onTap();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(
                videoTitle: videoTitle,
                videoUri: videoLink,
              ),
            ),
          );
        },
        child: SizedBox(
          height: 250,
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 100,
                    color: Colors.green.shade200,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      videoTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Icon(
                      Icons.more_vert_rounded,
                      color: Colors.grey.shade700,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
