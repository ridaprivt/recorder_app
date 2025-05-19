import 'package:record_app/model/recorded_video_model.dart';

abstract class PlaybackState {}

class PlaybackInitial extends PlaybackState {}

class PlaybackLoading extends PlaybackState {}

class PlaybackLoaded extends PlaybackState {
  final List<RecordedVideo> videos;
  PlaybackLoaded(this.videos);
}

class PlaybackError extends PlaybackState {
  final String message;
  PlaybackError(this.message);
}
