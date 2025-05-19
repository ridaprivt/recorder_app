import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_app/bloc/playback/playback_event.dart';
import 'package:record_app/widgets/video_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../bloc/playback/playback_bloc.dart';
import '../bloc/playback/playback_state.dart';

class PlaybackScreen extends StatefulWidget {
  const PlaybackScreen({super.key});

  @override
  State<PlaybackScreen> createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlaybackBloc>().add(LoadRecordedVideos());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black, title: const Text("Playback")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BlocBuilder<PlaybackBloc, PlaybackState>(
            builder: (context, state) {
              if (state is PlaybackLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PlaybackLoaded) {
                if (state.videos.isEmpty) {
                  return const Center(child: Text("No recordings found."));
                }

                return ListView.separated(
                  padding: EdgeInsets.all(5.w),
                  itemCount: state.videos.length,
                  separatorBuilder: (_, __) => SizedBox(height: 2.h),
                  itemBuilder: (context, index) {
                    final video = state.videos[index];
                    return VideoTile(video: video);
                  },
                );
              } else if (state is PlaybackError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
