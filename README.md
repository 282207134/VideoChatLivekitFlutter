# LiveKit Flutter Video Call

A simple and elegant Flutter video calling application using the LiveKit SDK. This app demonstrates how to build a real-time video communication platform with support for multiple participants.

## 🎯 Features

- ✅ **Real-time Video Calling** - Crystal clear video with LiveKit's optimized codec
- ✅ **Audio Communication** - High-quality audio with noise suppression
- ✅ **Multi-Participant Support** - Connect with multiple users in a single room
- ✅ **Camera Control** - Toggle camera on/off during calls
- ✅ **Microphone Control** - Mute/unmute microphone functionality
- ✅ **Permission Handling** - Automatic camera and microphone permission requests
- ✅ **Clean UI** - Material Design 3 user interface
- ✅ **Android & iOS Support** - Works on both major mobile platforms
- ✅ **Responsive Layout** - Adapts to different screen sizes and orientations

## 🚀 Quick Start

### Prerequisites

Before running this app, make sure you have:

- **Flutter SDK** (3.10.0 or higher)
- **Dart SDK** (3.0.0 or higher)
- **Android SDK** (for Android development)
- **Xcode** (for iOS development on macOS)
- **LiveKit Cloud Account** or self-hosted LiveKit server

### Installation

1. **Clone the Repository**
```bash
git clone <repository-url>
cd livekit-flutter-video-call
```

2. **Get Dependencies**
```bash
flutter pub get
```

3. **Run the App**

For Android:
```bash
flutter run -d android
```

For iOS:
```bash
flutter run -d ios
```

For all devices:
```bash
flutter run
```

## 📱 Application Structure

```
lib/
├── main.dart                 # App entry point and routing
├── screens/
│   ├── home_screen.dart      # Main screen for joining rooms
│   └── call_screen.dart      # Active video call screen
├── services/
│   └── livekit_service.dart  # LiveKit SDK wrapper service
└── widgets/
    ├── participant_widget.dart    # Individual participant video tile
    └── room_input_dialog.dart     # Dialog for room details input

android/                      # Android platform code
├── app/
│   ├── build.gradle          # Android build configuration
│   └── src/main/
│       ├── AndroidManifest.xml
│       └── kotlin/
│           └── MainActivity.kt
ios/                          # iOS platform code
└── Runner/
    └── Info.plist            # iOS configuration
```

## 💻 Usage

### 1. Getting LiveKit Credentials

#### Option A: LiveKit Cloud (Recommended for Beginners)

1. Visit [cloud.livekit.io](https://cloud.livekit.io)
2. Sign up for a free account
3. Create a new project
4. Copy your WebRTC URL (e.g., `wss://your-project.livekit.cloud`)
5. Get your API Key and Secret

#### Option B: Self-Hosted LiveKit

```bash
# Using Docker
docker run -d \
  -p 7880:7880 \
  -p 7881:7881 \
  -p 7882:7882/udp \
  -p 7883:7883/udp \
  livekit/livekit-server
```

Your server will be at `ws://localhost:7880`

### 2. Generate JWT Token

#### Using Node.js

```bash
npm install livekit
```

```javascript
const { AccessToken } = require("livekit-server-sdk");

const at = new AccessToken("api-key", "api-secret");
at.identity = "user-name";
at.addGrant({
  roomJoin: true,
  room: "room-name",
  canPublish: true,
  canSubscribe: true,
});

console.log(at.toJwt());
```

#### Using Python

```bash
pip install livekit
```

```python
from livekit import AccessToken, VideoGrants

token = AccessToken("api-key", "api-secret")
token.identity = "user-name"
token.add_grant(VideoGrants(
    room_join=True,
    room="room-name",
    can_publish=True,
    can_subscribe=True
))

print(token.toJwt())
```

### 3. Using the App

1. **Launch the App** on your device
2. **Tap "Join Room"** button
3. **Enter the following**:
   - **LiveKit Server URL**: Your server URL (ws:// or wss://)
   - **JWT Token**: Token generated for your identity
   - **Room Name**: Name of the room to join
4. **Grant Permissions**: Allow camera and microphone access when prompted
5. **Start Calling**: Your video will appear, and you can see other participants
6. **Control Options**:
   - 🎤 Mute/Unmute microphone
   - 📹 Turn camera on/off
   - 📞 End call and return to home

## 🔧 Development

### Project Dependencies

```yaml
dependencies:
  livekit_client: ^0.5.0      # LiveKit SDK
  permission_handler: ^11.4.0 # Permission management
  flutter: sdk
  cupertino_icons: ^1.0.2
  intl: ^0.19.0

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^2.0.0
```

### Building the App

#### Debug Build

```bash
# APK for Android
flutter build apk --debug

# iOS for simulator
flutter build ios --debug --simulator
```

#### Release Build

```bash
# APK for Android
flutter build apk --release

# App Bundle for Google Play (recommended)
flutter build appbundle --release

# iOS for device
flutter build ios --release
```

## 📋 Deployment Guide

For detailed deployment instructions, see [DEPLOYMENT.md](./DEPLOYMENT.md) which includes:

- ✅ Complete setup guide for Android
- ✅ Complete setup guide for iOS
- ✅ Google Play Store deployment
- ✅ Apple App Store deployment
- ✅ LiveKit server configuration
- ✅ JWT token generation
- ✅ Troubleshooting guide
- ✅ Performance optimization

## 🎨 UI Components

### Home Screen

- Welcome message with app icon
- "Join Room" button
- Requirements information card
- Clean Material Design 3 interface

### Call Screen

- Grid layout for video participants
- Participant names and audio status
- Bottom control panel with:
  - 🎤 Microphone toggle
  - 📹 Camera toggle
  - 📞 End call button
- Automatic handling of incoming participants

### Permission Dialog

- Room details input fields:
  - LiveKit Server URL
  - JWT Token
  - Room Name
- Input validation
- Loading state during connection

## 🔐 Security Considerations

1. **JWT Tokens**: Never commit tokens to version control
2. **HTTPS/WSS**: Always use `wss://` for production
3. **Token Expiration**: Set appropriate token expiration times
4. **API Keys**: Store API keys securely on your backend
5. **Permissions**: Request only necessary permissions

## 🐛 Troubleshooting

### Common Issues

**Can't connect to server?**
- Verify the URL includes protocol (ws:// or wss://)
- Check firewall settings
- Ensure LiveKit server is running

**Black screen during call?**
- Check camera permissions are granted
- Restart the app
- Try on a different device

**No audio?**
- Check microphone permissions
- Verify device volume is not muted
- Check other app's microphone settings

**App crashes on startup?**
- Run `flutter clean`
- Run `flutter pub get`
- Rebuild and run

For more troubleshooting, see [DEPLOYMENT.md](./DEPLOYMENT.md#troubleshooting)

## 📚 Resources

- **Flutter Documentation**: https://flutter.dev/docs
- **LiveKit SDK Documentation**: https://docs.livekit.io
- **LiveKit Flutter SDK**: https://pub.dev/packages/livekit_client
- **LiveKit GitHub**: https://github.com/livekit

## 🤝 Contributing

Contributions are welcome! Please feel free to:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 💡 Tips & Best Practices

### For Users

1. **Lighting**: Ensure adequate lighting for better video quality
2. **Bandwidth**: Use WiFi for best experience
3. **Distance**: Position camera 30-60cm away from your face
4. **Background**: Use a clean, professional background
5. **Permissions**: Grant all required permissions for full functionality

### For Developers

1. **Testing**: Always test on real devices, not just emulators
2. **Permissions**: Handle permission denials gracefully
3. **Error Handling**: Implement proper error handling and user feedback
4. **Memory Management**: Properly dispose resources in `dispose()` methods
5. **Network State**: Handle network state changes during calls

## 🔄 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2024 | Initial release with basic video calling |

## 📞 Support

If you encounter issues or have questions:

1. Check [Troubleshooting](./DEPLOYMENT.md#troubleshooting) section
2. Review [LiveKit Documentation](https://docs.livekit.io)
3. Open an issue on GitHub
4. Contact LiveKit support

## 🎓 Learning Resources

### Understanding WebRTC
- [WebRTC Explained](https://webrtc.org/getting-started)
- [Real-time Communication Concepts](https://www.html5rocks.com/en/tutorials/webrtc/basics/)

### Flutter Best Practices
- [Flutter Architecture Patterns](https://flutter.dev/docs/development/architecture)
- [State Management Guide](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

### LiveKit Integration
- [LiveKit Client SDK Guide](https://docs.livekit.io/guides/integrate-client-sdk/)
- [JWT Token Generation](https://docs.livekit.io/guides/access-control/)

---

**Happy coding! 🚀**

Last updated: 2024
