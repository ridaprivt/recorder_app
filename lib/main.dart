import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_app/bloc/playback/playback_bloc.dart';
import 'package:record_app/bloc/playback/playback_event.dart';
import 'package:record_app/bloc/recording/recording_bloc.dart';
import 'package:record_app/screens/recording_screen.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const RecordApp());
}

class RecordApp extends StatelessWidget {
  const RecordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => PlaybackBloc()..add(LoadRecordedVideos()),
            ),
            BlocProvider<RecordingBloc>(
              create: (_) => RecordingBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Screen Recorder',
            theme: ThemeData.dark().copyWith(
              primaryColor: Color(0xFF4A00E0),
            ),
            home: const RecordingScreen(),
          ),
        );
      },
    );
  }
}
