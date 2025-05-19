import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_app/services/recording_service.dart';
import 'recording_event.dart';
import 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final RecordingService _recordingService;
  Duration? selectedDuration;
  Timer? _timer;

  RecordingBloc(this._recordingService) : super(RecordingInitial()) {
    on<SelectDuration>((event, emit) {
      selectedDuration = event.duration;
    });

    on<StartRecording>((event, emit) async {
      if (selectedDuration == null) {
        emit(RecordingError("Please select a recording duration."));
        return;
      }

      final fileName = "rec_${DateTime.now().millisecondsSinceEpoch}";

      final started = await _recordingService.startRecording(fileName);

      if (!started) {
        emit(RecordingError("Failed to start recording."));
        return;
      }

      emit(RecordingInProgress(selectedDuration!));

      _timer?.cancel();
      _timer = Timer(selectedDuration!, () {
        add(StopRecording());
      });
    });

    on<StopRecording>((event, emit) async {
      _timer?.cancel();
      final path = await _recordingService.stopRecording();
      print("📁 Recording saved to: $path");
      emit(RecordingStopped(path));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
