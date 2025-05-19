# 📹 record_app

A Flutter application for **in-app screen recording** and **video playback**. Users can record the screen activity of this Flutter app for a selected duration and then view, play, and manage recorded sessions.

## ✨ Features

- 🎥 Record only the current Flutter app's UI
- ⏱️ Choose from preset durations: 15s, 30s, 1 min, 2 mins
- 📂 Save recordings to local storage (cache or external dir)
- ▶️ Playback with video list including:
  - Recording name
  - Timestamp
  - File size
  - Video duration
- 📱 Beautiful gradient UI
- 🚫 Avoids recording system UI or other apps

## 📸 Screenshots

*(Add screenshots here if needed)*

## 📦 Dependencies

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc)
- [`video_player`](https://pub.dev/packages/video_player)
- [`permission_handler`](https://pub.dev/packages/permission_handler)
- [`flutter_screen_recording`](https://pub.dev/packages/flutter_screen_recording)
- [`responsive_sizer`](https://pub.dev/packages/responsive_sizer)
- [`path_provider`](https://pub.dev/packages/path_provider)

## 🔧 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ridaprivt/recorder_app.git
   cd record_app
