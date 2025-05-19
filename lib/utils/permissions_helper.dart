import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  /// Requests necessary permissions for screen recording.
  static Future<bool> requestRecordingPermissions() async {
    // 🔁 Request one by one to avoid PlatformException
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) return false;

    final storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) return false;

    return true;
  }

  /// Checks if all required permissions are already granted.
  static Future<bool> hasPermissions() async {
    final mic = await Permission.microphone.status;
    final storage = await Permission.storage.status;
    return mic.isGranted && storage.isGranted;
  }
}
