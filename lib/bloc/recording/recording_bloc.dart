import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'recording_event.dart';
import 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  Duration? selectedDuration;
  Timer? _timer;

  RecordingBloc() : super(RecordingInitial()) {
    on<SelectDuration>((event, emit) {
      selectedDuration = event.duration;
    });

    on<StartRecording>((event, emit) async {
      if (selectedDuration == null) {
        emit(RecordingError("Please select a recording duration."));
        return;
      }

      final fileName =
          "rec_${DateTime.now().millisecondsSinceEpoch.toString()}";

      final started = await FlutterScreenRecording.startRecordScreen(fileName);

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
      final path = await FlutterScreenRecording.stopRecordScreen;
      print("📁 stopRecordScreen returned: $path");
      emit(RecordingStopped(path));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
