# LiveKit Flutter Video Call - Optional Features

This guide covers optional features and enhancements you can add to the application.

## Table of Contents

1. [Firebase Integration](#firebase-integration)
2. [Analytics](#analytics)
3. [Crash Reporting](#crash-reporting)
4. [Push Notifications](#push-notifications)
5. [Backend Server](#backend-server)

---

## Firebase Integration

Firebase provides excellent tools for analytics, crash reporting, and remote configuration.

### 1. Setup Firebase Project

1. Visit [Firebase Console](https://console.firebase.google.com)
2. Create new project
3. Add Android app:
   - Package name: `com.livekit.videocall`
   - Download `google-services.json`
   - Place in `android/app/`
4. Add iOS app:
   - Bundle ID: `com.livekit.videocall`
   - Download `GoogleService-Info.plist`
   - Add to `ios/Runner/`

### 2. Add Firebase Dependencies

Update `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^2.13.0
  firebase_analytics: ^10.4.0
  firebase_crashlytics: ^3.3.0
```

### 3. Initialize Firebase

Create `lib/firebase_options.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}
```

---

## Analytics

Track user behavior and app usage.

### 1. Basic Analytics Events

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Track room join
  static Future<void> logRoomJoined(String roomName) async {
    await _analytics.logEvent(
      name: 'room_joined',
      parameters: {
        'room_name': roomName,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // Track call duration
  static Future<void> logCallDuration(Duration duration) async {
    await _analytics.logEvent(
      name: 'call_ended',
      parameters: {
        'duration_seconds': duration.inSeconds,
      },
    );
  }

  // Track button clicks
  static Future<void> logButtonClick(String buttonName) async {
    await _analytics.logEvent(
      name: 'button_clicked',
      parameters: {
        'button_name': buttonName,
      },
    );
  }
}
```

### 2. Custom User Properties

```dart
// Set user ID
await FirebaseAnalytics.instance.setUserId(id: 'user_123');

// Set user properties
await FirebaseAnalytics.instance.setUserProperty(
  name: 'device_type',
  value: 'mobile',
);

await FirebaseAnalytics.instance.setUserProperty(
  name: 'app_version',
  value: '1.0.0',
);
```

### 3. View Analytics in Console

- Visit Firebase Console
- Analytics > Events
- Check real-time events
- Review user demographics
- Analyze user flow

---

## Crash Reporting

Automatically track and report app crashes.

### 1. Setup Crashlytics

Update `pubspec.yaml`:

```yaml
dependencies:
  firebase_crashlytics: ^3.3.0
```

### 2. Initialize Crashlytics

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  // Capture Flutter errors
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  // Capture async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  runApp(const MyApp());
}
```

### 3. Log Exceptions

```dart
// Catch and log exceptions
try {
  await _liveKitService.connect(url, token, roomName);
} catch (e, stackTrace) {
  FirebaseCrashlytics.instance.recordError(
    e,
    stackTrace,
    reason: 'Failed to connect to LiveKit',
  );
  rethrow;
}
```

### 4. Set Custom Keys

```dart
// Add context to crashes
FirebaseCrashlytics.instance.setCustomKey('room_name', roomName);
FirebaseCrashlytics.instance.setCustomKey('user_id', userId);
FirebaseCrashlytics.instance.setCustomKey('device_model', deviceModel);
```

### 5. View Crashes in Console

- Visit Firebase Console
- Crashlytics
- Review recent crashes
- Check stack traces
- Identify patterns

---

## Push Notifications

Send real-time notifications to users.

### 1. Setup Firebase Cloud Messaging (FCM)

```bash
# Add to pubspec.yaml
firebase_messaging: ^14.6.0
```

### 2. Request Permission

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> requestNotificationPermission() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not yet granted permission');
  }
}
```

### 3. Handle Messages

```dart
// Handle foreground messages
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Received message: ${message.notification?.title}');
  // Show notification
});

// Handle background messages
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) {
  print('Handling a background message: ${message.messageId}');
}
```

### 4. Get FCM Token

```dart
// Get device token
final token = await FirebaseMessaging.instance.getToken();
print('FCM Token: $token');

// Send token to your backend
// Your backend can use this to send notifications
```

---

## Backend Server

Create a backend server for token generation and room management.

### 1. Node.js Example

```javascript
// server.js
const express = require('express');
const { AccessToken } = require('livekit-server-sdk');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const apiKey = process.env.LIVEKIT_API_KEY;
const apiSecret = process.env.LIVEKIT_API_SECRET;
const liveKitUrl = process.env.LIVEKIT_URL;

// Generate token endpoint
app.post('/api/token', (req, res) => {
  try {
    const { identity, roomName, metadata } = req.body;

    if (!identity || !roomName) {
      return res.status(400).json({
        error: 'identity and roomName required',
      });
    }

    const token = new AccessToken(apiKey, apiSecret);
    token.identity = identity;
    token.name = identity;
    token.metadata = metadata || '';

    token.addGrant({
      roomJoin: true,
      room: roomName,
      canPublish: true,
      canPublishData: true,
      canSubscribe: true,
    });

    return res.json({
      token: token.toJwt(),
      url: liveKitUrl,
    });
  } catch (error) {
    return res.status(500).json({
      error: error.message,
    });
  }
});

// Room info endpoint
app.get('/api/rooms/:roomName', async (req, res) => {
  try {
    const { roomName } = req.params;
    const svc = new RoomServiceClient(liveKitUrl, apiKey, apiSecret);
    
    const rooms = await svc.listRooms([roomName]);
    
    if (rooms.length === 0) {
      return res.status(404).json({
        error: 'Room not found',
      });
    }

    return res.json(rooms[0]);
  } catch (error) {
    return res.status(500).json({
      error: error.message,
    });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

### 2. Python Example

```python
# server.py
from flask import Flask, request, jsonify
from flask_cors import CORS
from livekit import AccessToken, VideoGrants
import os

app = Flask(__name__)
CORS(app)

API_KEY = os.getenv('LIVEKIT_API_KEY')
API_SECRET = os.getenv('LIVEKIT_API_SECRET')
LIVEKIT_URL = os.getenv('LIVEKIT_URL')

@app.route('/api/token', methods=['POST'])
def generate_token():
    try:
        data = request.get_json()
        identity = data.get('identity')
        room_name = data.get('roomName')
        metadata = data.get('metadata', '')

        if not identity or not room_name:
            return jsonify({'error': 'identity and roomName required'}), 400

        token = AccessToken(API_KEY, API_SECRET)
        token.identity = identity
        token.name = identity
        token.metadata = metadata

        token.add_grant(VideoGrants(
            room_join=True,
            room=room_name,
            can_publish=True,
            can_subscribe=True
        ))

        return jsonify({
            'token': token.toJwt(),
            'url': LIVEKIT_URL,
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=3000)
```

### 3. Update Flutter App to Use Backend

```dart
class LiveKitService {
  final String backendUrl;

  LiveKitService({this.backendUrl = 'http://localhost:3000'});

  Future<void> joinRoomWithBackend(
    String identity,
    String roomName,
  ) async {
    try {
      // Get token from backend
      final response = await http.post(
        Uri.parse('$backendUrl/api/token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'identity': identity,
          'roomName': roomName,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get token');
      }

      final data = jsonDecode(response.body);
      final url = data['url'];
      final token = data['token'];

      // Connect to LiveKit
      await connect(url, token, roomName);
    } catch (e) {
      print('Error joining room: $e');
      rethrow;
    }
  }
}
```

---

## Advanced Features

### 1. Recording

```dart
// LiveKit will automatically record if configured
// Check LiveKit Dashboard > Rooms > Recording
```

### 2. Transcription

```dart
// Enable in LiveKit configuration
// Cloud console settings > Recording & Transcription
```

### 3. Room Management

```dart
// Check active rooms
final rooms = await roomService.listRooms();

// Delete room
await roomService.deleteRoom('room-name');

// Get room info
final info = await roomService.listRooms(['room-name']);
```

### 4. Webhooks

```javascript
// Receive room events
app.post('/webhook/livekit', (req, res) => {
  const event = req.body;
  
  console.log('Event:', event.event);
  console.log('Room:', event.room?.name);
  
  // Handle events:
  // - participant_joined
  // - participant_left
  // - room_started
  // - room_finished
  
  res.sendStatus(200);
});
```

---

## Security Best Practices

1. **Never hardcode credentials** in the app
2. **Use backend for token generation**
3. **Implement rate limiting** on token endpoint
4. **Validate JWT tokens** before allowing connections
5. **Use HTTPS/WSS** in production
6. **Implement CORS** properly on backend
7. **Monitor token expiration** and refresh
8. **Log security events** for audit trail

---

## Performance Optimization

### 1. Memory Management

```dart
@override
void dispose() {
  _room?.disconnect();
  _participants.clear();
  super.dispose();
}
```

### 2. Battery Optimization

```dart
// Reduce video resolution on battery saver
if (Platform.isAndroid) {
  final batteryManager = BatteryManager();
  if (await batteryManager.isBatterySaverOn) {
    // Use lower resolution
  }
}
```

### 3. Network Optimization

```dart
// Use adaptive bitrate
RoomOptions(
  adaptiveStream: true,
  dynacast: true,
)
```

---

## Testing

### 1. Unit Testing

```dart
test('LiveKit service initialization', () async {
  final service = LiveKitService();
  expect(service.room, isNull);
});
```

### 2. Integration Testing

```dart
testWidgets('Join room flow', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  await tester.tap(find.byIcon(Icons.phone));
  await tester.pump();
  
  expect(find.byType(AlertDialog), findsOneWidget);
});
```

---

## Next Steps

1. Implement features as needed
2. Monitor analytics and crashes
3. Optimize based on real-world usage
4. Gather user feedback
5. Plan new features

---

**Last Updated**: 2024
