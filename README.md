# LiveKit Flutter Video Chat

A simple Flutter video chat application using LiveKit.

## Quick Start

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Configuration

The app uses built-in configuration for demo purposes. For production, update the values in `lib/config/livekit_config.dart`:

```dart
class LiveKitConfig {
  static const String url = 'wss://your-livekit-server.com';
  static const String apiKey = 'your-api-key';
  static const String apiSecret = 'your-api-secret';
}
```

## Features

- Video chat with multiple participants
- Camera and microphone controls
- Real-time participant management

## Requirements

- Flutter SDK >=3.0.0
- LiveKit server