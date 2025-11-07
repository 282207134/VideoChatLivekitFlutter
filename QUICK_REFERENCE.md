# LiveKit Flutter Video Call - Quick Reference

## Getting Started in 5 Minutes

### 1. Setup Development Environment
```bash
# Install Flutter (choose your OS from https://flutter.dev/docs/get-started/install)

# Verify installation
flutter doctor

# Clone repository
git clone <repository-url>
cd livekit-flutter-video-call

# Get dependencies
flutter pub get
```

### 2. Get LiveKit Credentials
- Visit: https://cloud.livekit.io
- Create account and project
- Copy: WebRTC URL, API Key, API Secret

### 3. Generate Token
```bash
npm install livekit-server-sdk

# Create generate_token.js with API key/secret, run it to get JWT token
```

### 4. Run the App
```bash
flutter run
```

### 5. Use the App
- Tap "Join Room"
- Enter: Server URL, JWT Token, Room Name
- Allow permissions
- Start calling!

---

## Common Commands

### Development
```bash
flutter run              # Run app on default device
flutter run -d android   # Run on Android
flutter run -d ios       # Run on iOS (macOS only)
flutter run --profile   # Run with profiling
flutter run -v          # Verbose output
```

### Building
```bash
flutter build apk --release           # Android APK
flutter build appbundle --release     # Android Bundle (for Google Play)
flutter build ios --release           # iOS app
```

### Maintenance
```bash
flutter clean           # Clean build files
flutter pub get         # Get dependencies
flutter pub upgrade     # Upgrade dependencies
flutter analyze         # Check code quality
dart format .          # Format code
```

---

## Project Structure Quick Map

```
lib/
├── main.dart           → App entry point & routing
├── screens/
│   ├── home_screen.dart    → Join room UI
│   └── call_screen.dart    → Video call UI
├── services/
│   └── livekit_service.dart → LiveKit integration
├── widgets/
│   ├── participant_widget.dart → Video tiles
│   └── room_input_dialog.dart  → Input form
└── utils/
    ├── app_config.dart → Configuration
    └── permission_helper.dart → Permissions

android/               → Android configuration
ios/                  → iOS configuration
```

---

## Token Generation Examples

### Node.js
```javascript
const { AccessToken } = require("livekit-server-sdk");

const token = new AccessToken("api_key", "api_secret");
token.identity = "user_name";
token.addGrant({
  roomJoin: true,
  room: "room_name",
  canPublish: true,
  canSubscribe: true,
});

console.log(token.toJwt());
```

### Python
```python
from livekit import AccessToken, VideoGrants

token = AccessToken("api_key", "api_secret")
token.identity = "user_name"
token.add_grant(VideoGrants(
    room_join=True,
    room="room_name",
    can_publish=True,
    can_subscribe=True
))

print(token.toJwt())
```

---

## Troubleshooting Quick Fixes

| Problem | Solution |
|---------|----------|
| `flutter doctor` errors | Run `flutter doctor --android-licenses` |
| Build fails | Run `flutter clean && flutter pub get` |
| iOS pod issues | `cd ios && rm -rf Pods && pod install --repo-update && cd ..` |
| Can't connect | Check URL has ws:// or wss://, verify token |
| Black screen | Check camera permissions, restart app |
| No audio | Check microphone permissions, device not muted |
| App crashes | Run `flutter run -v` to see error logs |

---

## Key Files Explained

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Dependencies and project config |
| `lib/main.dart` | App startup and routing |
| `lib/services/livekit_service.dart` | LiveKit SDK wrapper |
| `android/AndroidManifest.xml` | Android permissions |
| `ios/Runner/Info.plist` | iOS permissions |
| `DEPLOYMENT.md` | Full deployment guide |
| `SETUP_GUIDE.md` | Environment setup |

---

## Resources

| Resource | Link |
|----------|------|
| Flutter Docs | https://flutter.dev/docs |
| LiveKit Docs | https://docs.livekit.io |
| LiveKit SDK | https://pub.dev/packages/livekit_client |
| Android Studio | https://developer.android.com/studio |
| Xcode | https://developer.apple.com/xcode |

---

## Development Workflow

```
1. Create branch: git checkout -b feature/my-feature
2. Make changes in lib/
3. Hot reload: press 'r' in terminal (during flutter run)
4. Commit: git commit -m "feat: description"
5. Push: git push origin feature/my-feature
6. Create pull request
```

---

## Important Permissions

- **Camera**: Allows video capture
- **Microphone**: Allows audio capture
- **Internet**: Connects to server
- **Network State**: Checks connectivity

Request in AndroidManifest.xml and Info.plist (already configured)

---

## API Quick Reference

```dart
// Connect to room
await liveKitService.connect(url, token, roomName);

// Toggle microphone
liveKitService.toggleMicrophone(enabled);

// Toggle camera
liveKitService.toggleCamera(enabled);

// Disconnect from room
await liveKitService.disconnect();

// Get participants stream
liveKitService.participantsStream
```

---

## UI Components

| Component | File | Purpose |
|-----------|------|---------|
| Home Screen | home_screen.dart | Room join interface |
| Call Screen | call_screen.dart | Video call interface |
| Participant | participant_widget.dart | Individual video tile |
| Room Dialog | room_input_dialog.dart | Connection details form |

---

## Deployment Checklist

- [ ] Update app version in `pubspec.yaml`
- [ ] Test on real devices (both Android & iOS)
- [ ] Generate signing key (Android)
- [ ] Create app store accounts (iOS)
- [ ] Build release APK/Bundle (Android)
- [ ] Build release IPA (iOS)
- [ ] Create app store listings
- [ ] Submit for review
- [ ] Monitor for crashes/analytics

---

## Performance Tips

1. Use `const` constructors whenever possible
2. Dispose resources in `dispose()` method
3. Use `StreamBuilder` instead of `setState`
4. Limit video resolution on poor networks
5. Cache expensive computations
6. Monitor memory with DevTools

---

## Security Tips

1. Never hardcode API keys or tokens
2. Use HTTPS/WSS in production
3. Implement token expiration
4. Validate all user inputs
5. Use secure token generation on backend
6. Don't store tokens on device
7. Clear sensitive data on logout

---

## File Modifications for Your Project

### Update Application ID (Android)
Edit `android/app/build.gradle`:
```gradle
applicationId "com.yourcompany.yourapp"
```

### Update Bundle ID (iOS)
Edit `ios/Runner.pbxproj`:
```
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.yourapp;
```

### Update App Name
Edit `pubspec.yaml`:
```yaml
name: your_app_name
```

---

## Next Steps

1. **Quick Setup**: Follow Getting Started above
2. **Full Setup**: Read [SETUP_GUIDE.md](./SETUP_GUIDE.md)
3. **Deploy**: Read [DEPLOYMENT.md](./DEPLOYMENT.md)
4. **Enhance**: Check [OPTIONAL_FEATURES.md](./OPTIONAL_FEATURES.md)

---

## Support

- **Issues**: Check Troubleshooting section above
- **Documentation**: See [README.md](./README.md)
- **Deployment**: See [DEPLOYMENT.md](./DEPLOYMENT.md)
- **Setup**: See [SETUP_GUIDE.md](./SETUP_GUIDE.md)

---

**Quick Reference Last Updated**: 2024
