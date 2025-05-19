abstract class RecordingEvent {}

class SelectDuration extends RecordingEvent {
  final Duration duration;
  SelectDuration(this.duration);
}

class StartRecording extends RecordingEvent {}

class StopRecording extends RecordingEvent {}
