import 'package:flutter/material.dart';
import 'package:record_app/model/recorded_video_model.dart';
import 'package:record_app/screens/video_player_screen.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
    required this.video,
  });

  final RecordedVideo video;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(videoPath: video.path),
          ),
        );
      },
      leading: const Icon(Icons.videocam, color: Colors.deepPurple),
      title: Text(video.name),
      subtitle: Text(
        "${video.formattedDate} · ⏱ ${video.formattedDuration}",
      ),
      trailing: Icon(Icons.play_arrow),
    );
  }
}
