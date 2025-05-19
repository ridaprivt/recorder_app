# 📹 record_app

A Flutter application for **in-app screen recording** and **video playback**. This app allows users to **record only the current Flutter UI** for a selected duration and then view, play, and manage the recorded sessions.

## ✨ Features

- 🎥 Record **only** the Flutter app’s UI
- ⏱️ Select recording durations: **15s**, **30s**, **1 min**, **2 mins**
- 💾 Save recordings to local storage (cache/external)
- ▶️ View and play recorded videos with metadata:
  - Recording name
  - Timestamp
  - Video duration
- 🌈 Modern, responsive UI with gradient design


## 📦 Dependencies

This app uses the following Flutter packages:

| Package | Description |
|--------|-------------|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | BLoC state management |
| [`video_player`](https://pub.dev/packages/video_player) | Playback of recorded videos |
| [`permission_handler`](https://pub.dev/packages/permission_handler) | Handles runtime permissions |
| [`flutter_screen_recording`](https://pub.dev/packages/flutter_screen_recording) | Records app UI only |
| [`responsive_sizer`](https://pub.dev/packages/responsive_sizer) | Device-responsive sizing |
| [`path_provider`](https://pub.dev/packages/path_provider) | Access storage directories |

> **State Management:**  
> The app follows the **BLoC (Business Logic Component)** pattern for clean separation of logic and UI.

## 🛡️ Android Permissions

The following permissions are required in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
