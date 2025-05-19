import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:record_app/model/recorded_video_model.dart';
import 'package:video_player/video_player.dart';

class StorageService {
  Future<List<RecordedVideo>> getRecordedVideos() async {
    final List<RecordedVideo> videos = [];

    try {
      final cacheDirs = await getExternalCacheDirectories();
      if (cacheDirs != null && cacheDirs.isNotEmpty) {
        for (final dir in cacheDirs) {
          if (await dir.exists()) {
            print("📂 Scanning cache directory: ${dir.path}");
            videos.addAll(await _scanDirectory(dir));
          }
        }
      }

      final appDir = await getExternalStorageDirectory();
      if (appDir != null && await appDir.exists()) {
        print("📂 Scanning app directory: ${appDir.path}");
        videos.addAll(await _scanDirectory(appDir));
      }

      final unique = {for (var v in videos) v.name: v}.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      print("✅ Found ${unique.length} unique video(s).");
      return unique;
    } catch (e) {
      print("❌ Failed to load recorded videos: $e");
      return [];
    }
  }

  Future<List<RecordedVideo>> _scanDirectory(Directory dir) async {
    final videoFiles = <RecordedVideo>[];

    for (var entity in dir.listSync()) {
      if (entity is File && entity.path.endsWith('.mp4')) {
        try {
          final stat = await entity.stat();
          final duration = await _getVideoDuration(entity);
          print("🎞️ Found: ${entity.path} (${stat.size} bytes)");

          videoFiles.add(
            RecordedVideo(
              path: entity.path,
              name: entity.uri.pathSegments.last,
              size: stat.size,
              date: stat.modified,
              duration: duration,
            ),
          );
        } catch (e) {
          print("⚠️ Failed to load duration for ${entity.path}: $e");
        }
      }
    }

    if (videoFiles.isEmpty) {
      print("📭 No .mp4 files found in ${dir.path}");
    }

    return videoFiles;
  }

  Future<Duration> _getVideoDuration(File file) async {
    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    final duration = controller.value.duration;
    await controller.dispose();
    return duration;
  }
}
