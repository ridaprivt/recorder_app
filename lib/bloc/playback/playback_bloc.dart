import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_app/services/storage_service.dart';
import 'playback_event.dart';
import 'playback_state.dart';

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackState> {
  final StorageService _storageService; // ✅ declare

  PlaybackBloc({StorageService? storageService})
      : _storageService = storageService ?? StorageService(), // allow injection
        super(PlaybackInitial()) {
    on<LoadRecordedVideos>((event, emit) async {
      emit(PlaybackLoading());
      try {
        final videos = await _storageService.getRecordedVideos();
        emit(PlaybackLoaded(videos));
      } catch (e) {
        emit(PlaybackError("Failed to load recordings: $e"));
      }
    });
  }
}
