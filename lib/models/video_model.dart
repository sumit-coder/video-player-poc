import 'package:meta/meta.dart';
import 'dart:convert';

List<Videos> videosFromJson(String str) =>
    List<Videos>.from(json.decode(str).map((x) => Videos.fromJson(x)));

class Videos {
  Videos({
    required this.id,
    required this.title,
    required this.videoUrl,
  });

  int id;
  String title;
  String videoUrl;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["id"],
        title: json["title"],
        videoUrl: json["video_url"],
      );
}
