abstract class RecordingState {}

class RecordingInitial extends RecordingState {}

class RecordingInProgress extends RecordingState {
  final Duration duration;
  RecordingInProgress(this.duration);
}

class RecordingStopped extends RecordingState {
  final String videoPath;
  RecordingStopped(this.videoPath);
}

class RecordingError extends RecordingState {
  final String message;
  RecordingError(this.message);
}
