import 'dart:core';

class RecordedVideo {
  final String path;
  final String name;
  final int size;
  final DateTime date;
  final Duration duration; // ✅ NEW

  RecordedVideo({
    required this.path,
    required this.name,
    required this.size,
    required this.date,
    required this.duration, // ✅ NEW
  });

  String get formattedSize {
    if (size >= 1000000) {
      return "${(size / 1000000).toStringAsFixed(1)} MB";
    } else if (size >= 1000) {
      return "${(size / 1000).toStringAsFixed(1)} KB";
    } else {
      return "$size B";
    }
  }

  String get formattedDate {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  String get formattedDuration {
    final mins = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }
}
