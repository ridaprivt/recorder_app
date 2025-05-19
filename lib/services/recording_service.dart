import 'package:flutter_screen_recording/flutter_screen_recording.dart';

class RecordingService {
  Future<bool> startRecording(String fileName) async {
    try {
      return await FlutterScreenRecording.startRecordScreen(fileName);
    } catch (e) {
      print("❌ Failed to start recording: $e");
      return false;
    }
  }

  Future<String> stopRecording() async {
    try {
      return await FlutterScreenRecording.stopRecordScreen;
    } catch (e) {
      print("❌ Failed to stop recording: $e");
      return "";
    }
  }
}
