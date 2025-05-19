import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black, title: const Text("Video Player")),
        body: Center(
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
