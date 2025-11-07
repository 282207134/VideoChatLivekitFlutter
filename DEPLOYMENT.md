# LiveKit Flutter Video Call - Deployment Guide

A comprehensive guide for deploying the LiveKit Flutter Video Call application on Android and iOS platforms.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Setup](#project-setup)
3. [Android Deployment](#android-deployment)
4. [iOS Deployment](#ios-deployment)
5. [LiveKit Server Setup](#livekit-server-setup)
6. [Testing](#testing)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before deploying the application, ensure you have the following installed:

### Required Software

- **Flutter SDK**: Version 3.10.0 or higher
  - Download from: https://flutter.dev/docs/get-started/install
  
- **Dart SDK**: Version 3.0.0 or higher (included with Flutter)

- **Git**: Version 2.0 or higher

### Platform-Specific Requirements

#### Android Requirements
- **Android SDK**: API level 21 or higher
- **Android Studio**: Latest version with Android SDK tools
- **Java Development Kit (JDK)**: Version 11 or higher
- **Kotlin**: Version 1.6 or higher

#### iOS Requirements
- **Xcode**: Version 13.0 or higher
- **CocoaPods**: Version 1.11 or higher
- **iOS Deployment Target**: 11.0 or higher
- **Swift**: Version 5.0 or higher

### Hardware Requirements
- **Development Machine**: macOS for iOS development, Windows/macOS/Linux for Android
- **Test Devices**: 
  - For Android: Device running Android 5.0+ or emulator
  - For iOS: Device running iOS 11.0+ or simulator

---

## Project Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd livekit-flutter-video-call
```

### 2. Install Flutter Dependencies

```bash
# Get all Dart dependencies
flutter pub get

# Upgrade dependencies to latest versions (optional)
flutter pub upgrade
```

### 3. Verify Installation

```bash
# Check Flutter environment
flutter doctor

# Expected output should show:
# ✓ Flutter (Channel stable, 3.10.0 or higher)
# ✓ Dart (bundled with Flutter)
# ✓ Android toolchain (if targeting Android)
# ✓ Xcode (if targeting iOS)
```

---

## Android Deployment

### 1. Configure Android Project

#### Set Application ID and Name

Edit `android/app/build.gradle`:

```gradle
defaultConfig {
    applicationId "com.livekit.videocall"  // Change to your unique app ID
    minSdkVersion flutter.minSdkVersion     // Usually 21
    targetSdkVersion flutter.targetSdkVersion
    versionCode 1
    versionName "1.0"
}
```

#### Configure Manifest Permissions

The `android/app/src/main/AndroidManifest.xml` already includes required permissions:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### 2. Build Configuration

#### Debug Build

For development and testing:

```bash
# Build APK for debugging
flutter build apk --debug

# Output: build/app/outputs/flutter-apk/app-debug.apk
```

#### Release Build

For production deployment:

```bash
# Build optimized APK for release
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### App Bundle (Recommended for Google Play)

```bash
# Build Android App Bundle for Google Play Store
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### 3. Signing Configuration

#### Generate Signing Key

```bash
# Generate a new keystore file (one-time setup)
keytool -genkey -v -keystore ~/key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload-key \
  -storepass your_store_password \
  -keypass your_key_password

# Windows:
keytool -genkey -v -keystore %USERPROFILE%\key.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias upload-key
```

#### Configure Gradle Signing

Create/edit `android/key.properties`:

```properties
storeFile=../key.jks
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=upload-key
```

Edit `android/app/build.gradle`:

```gradle
android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 4. Install on Device/Emulator

#### Using Physical Device

```bash
# Enable USB Debugging on your Android device
# Settings > Developer Options > USB Debugging

# List connected devices
flutter devices

# Install and run
flutter run -v
```

#### Using Android Emulator

```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>

# Run app on emulator
flutter run
```

### 5. Deploy to Google Play Store

1. **Create Google Play Developer Account** (one-time setup)
   - Visit: https://play.google.com/console
   - Pay one-time registration fee ($25)
   - Set up billing and merchant account

2. **Create Application**
   - Click "Create app"
   - Fill in app details (name, language, category)
   - Accept policies

3. **Upload App Bundle**

```bash
# Build release app bundle
flutter build appbundle --release

# Upload via Google Play Console:
# - Go to Release > Production
# - Upload app-release.aab
# - Fill in store listing details
# - Submit for review
```

4. **Complete Store Listing**
   - Add screenshots (min 2, max 8)
   - Add app description
   - Set content rating
   - Specify target audience
   - Add privacy policy URL

---

## iOS Deployment

### 1. Configure iOS Project

#### Update Bundle Identifier

```bash
# Open iOS project in Xcode
open ios/Runner.xcworkspace

# Or use Flutter commands
# Edit ios/Runner.pbxproj and change bundle ID to your unique identifier
```

#### Set iOS Version

Edit `ios/Podfile`:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_CAMERA=1',
        'PERMISSION_MICROPHONE=1',
      ]
    end
  end
end
```

### 2. Install Dependencies

```bash
# Install iOS dependencies
cd ios
pod install --repo-update
cd ..
```

### 3. Build Configuration

#### Debug Build

```bash
# Build for simulator
flutter build ios --debug --simulator

# Build for device
flutter build ios --debug
```

#### Release Build

```bash
# Build for release on physical device
flutter build ios --release

# Output: build/ios/iphoneos/Runner.app
```

### 4. Run on Device/Simulator

#### Using iOS Simulator

```bash
# List available simulators
xcrun xctrace list devices

# Run on simulator
flutter run -d "iPhone 14"
```

#### Using Physical Device

```bash
# Ensure device is trusted in Xcode
# List devices
flutter devices

# Install and run
flutter run -d <device_id>
```

### 5. Deploy to App Store

#### Prerequisites

- Apple Developer Account ($99/year)
- Apple ID
- Provisioning profiles and certificates

#### Deployment Steps

1. **Create App Store Connect Application**
   - Visit: https://appstoreconnect.apple.com
   - Click "My Apps"
   - Click "+" > "New App"
   - Fill in app details

2. **Prepare for Submission**

```bash
# Archive the app
open ios/Runner.xcworkspace

# In Xcode:
# - Select "Generic iOS Device" as target
# - Product > Archive
```

3. **Upload to App Store**

```bash
# Or use Xcode's built-in upload:
# Select archive > Distribute App > App Store Connect > Upload
```

4. **Complete App Store Information**
   - Add app screenshots (min 2 per screen size)
   - Add app preview video (optional)
   - Fill in description
   - Set keywords
   - Add category and subcategory
   - Set content rating
   - Specify age group

5. **Submit for Review**
   - Scroll to "App Review Information"
   - Add contact details
   - Add testing instructions
   - Click "Submit for Review"

---

## LiveKit Server Setup

### 1. Create LiveKit Account

1. Visit https://cloud.livekit.io
2. Sign up for an account
3. Create a new project
4. Get your API Key and API Secret

### 2. Generate JWT Tokens

#### Using Node.js

```bash
npm install livekit
```

Create `generate_token.js`:

```javascript
const { AccessToken } = require("livekit-server-sdk");

const apiKey = "your_api_key";
const apiSecret = "your_api_secret";

const at = new AccessToken(apiKey, apiSecret);
at.identity = "user_identity";
at.name = "User Name";
at.addGrant({
  roomJoin: true,
  room: "room_name",
  canPublish: true,
  canPublishData: true,
  canSubscribe: true,
});

console.log(at.toJwt());
```

Run:

```bash
node generate_token.js
```

#### Using Python

```bash
pip install livekit
```

Create `generate_token.py`:

```python
from livekit import AccessToken, VideoGrants

api_key = "your_api_key"
api_secret = "your_api_secret"

token = AccessToken(api_key, api_secret)
token.identity = "user_identity"
token.name = "User Name"
token.add_grant(VideoGrants(
    room_join=True,
    room="room_name",
    can_publish=True,
    can_subscribe=True
))

print(token.toJwt())
```

Run:

```bash
python generate_token.py
```

### 3. Using LiveKit Cloud

1. Go to https://cloud.livekit.io/projects
2. Select your project
3. Copy:
   - **WebRTC URL**: `wss://your-project.livekit.cloud`
   - **API Key** and **API Secret**

### 4. Self-Hosted LiveKit Server (Optional)

#### Using Docker

```bash
# Pull LiveKit Docker image
docker pull livekit/livekit-server

# Run LiveKit server
docker run -d \
  -p 7880:7880 \
  -p 7881:7881 \
  -p 7882:7882/udp \
  -p 7883:7883/udp \
  -e LIVEKIT_KEYS="API_KEY:API_SECRET" \
  -e LIVEKIT_WEBHOOK_API_KEY="your_webhook_key" \
  livekit/livekit-server
```

#### Using Kubernetes

```bash
# Deploy LiveKit using Helm chart
helm repo add livekit https://helm.livekit.io
helm install livekit livekit/livekit-server \
  --values values.yaml
```

---

## Testing

### 1. Pre-Deployment Testing

#### Manual Testing Checklist

- [ ] App starts without crashes
- [ ] Camera permission request works
- [ ] Microphone permission request works
- [ ] Video preview displays correctly
- [ ] Can connect to LiveKit server
- [ ] Audio transmission working
- [ ] Video transmission working
- [ ] Multiple participants visible
- [ ] Mute/unmute microphone works
- [ ] Turn camera on/off works
- [ ] Leave room/end call works
- [ ] Landscape orientation works (if supported)
- [ ] Network disconnection handled gracefully
- [ ] Low bandwidth scenarios work

#### Device Testing

Test on multiple devices:

```bash
# Test on different Android versions
flutter run -d <device_1_id>
flutter run -d <device_2_id>

# Test on different iOS versions
flutter run -d "iPhone 14"
flutter run -d "iPhone 13"
```

### 2. Performance Testing

#### Profiling

```bash
# Run with performance profiling
flutter run --profile
```

Monitor:
- Memory usage
- CPU usage
- Frame rate (should be 60 FPS)
- Battery consumption

### 3. Network Testing

#### Simulate Poor Network Conditions

**Android:**
```bash
# Using Android Emulator with Network Throttling
adb shell settings put global airplane_mode_on 0
adb shell cmd connectivity airplane-mode off

# Or use ChromeDevTools for WebRTC debugging
```

**iOS:**
```bash
# Using Xcode Network Link Conditioner
# Download from: https://additional.download.developer.apple.com
```

---

## Troubleshooting

### Common Issues

#### 1. Flutter Doctor Issues

**Problem**: `flutter doctor` shows missing components

**Solution**:
```bash
# Install missing components
flutter doctor --verbose

# Accept Android licenses
flutter config --android-studio-dir="/path/to/android-studio"
flutter doctor --android-licenses
```

#### 2. Build Failures on Android

**Problem**: `Gradle sync failed` or `Build failed`

**Solution**:
```bash
# Clean build
flutter clean
rm -rf android/build
rm -rf build

# Rebuild
flutter pub get
flutter build apk --verbose
```

#### 3. iOS Pod Installation Issues

**Problem**: `pod install` fails with conflicts

**Solution**:
```bash
cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install --repo-update
cd ..
```

#### 4. Permission Denied on Android

**Problem**: App crashes when accessing camera/microphone

**Solution**:
- Add permissions to `AndroidManifest.xml`
- Request runtime permissions in code
- Test on device with Android 6.0+ (requires runtime permissions)

#### 5. WebRTC Connection Issues

**Problem**: Cannot connect to LiveKit server

**Solution**:
- Verify server URL is correct (ws:// or wss://)
- Verify JWT token is valid
- Check firewall settings
- Verify room name matches
- Check LiveKit server logs

#### 6. Camera/Microphone Not Working

**Problem**: Black screen or no audio

**Solution**:
```dart
// Check permissions
import 'package:permission_handler/permission_handler.dart';

final cameraStatus = await Permission.camera.request();
final micStatus = await Permission.microphone.request();

print('Camera: ${cameraStatus.isGranted}');
print('Microphone: ${micStatus.isGranted}');
```

#### 7. Memory Leaks

**Problem**: App crashes after long video call

**Solution**:
```dart
@override
void dispose() {
  // Always dispose resources
  _liveKitService.disconnect();
  super.dispose();
}
```

### Performance Optimization

#### 1. Code Optimization

```dart
// Use const constructors
const MyWidget()

// Avoid rebuilding
StreamBuilder instead of setState

// Use keys properly
key: ValueKey(participant.sid)
```

#### 2. Build Size Optimization

```bash
# Check build size
flutter build apk --release --split-per-abi

# Analyze dependencies
flutter pub deps --style=tree

# Use tree shaking
flutter build apk --split-debug-info
```

#### 3. Network Optimization

```dart
// Enable adaptive stream
RoomOptions(
  adaptiveStream: true,
  dynacast: true,
)
```

---

## Additional Resources

### Documentation

- **Flutter Documentation**: https://flutter.dev/docs
- **LiveKit Documentation**: https://docs.livekit.io
- **LiveKit Flutter SDK**: https://pub.dev/packages/livekit_client

### Support

- **Flutter Issues**: https://github.com/flutter/flutter/issues
- **LiveKit Issues**: https://github.com/livekit/client-sdk-flutter/issues
- **Stack Overflow**: Tag questions with `flutter` and `livekit`

### Related Tools

- **Android Studio**: https://developer.android.com/studio
- **Xcode**: https://developer.apple.com/xcode
- **Firebase Console**: https://console.firebase.google.com (for analytics/crash reporting)

---

## Version History

- **v1.0.0** (2024) - Initial release with basic video calling functionality

## License

This project is licensed under the MIT License.

---

## Contributing

If you encounter issues or have suggestions, please submit:
1. Bug reports on GitHub Issues
2. Feature requests with detailed descriptions
3. Pull requests for improvements

---

**Last Updated**: 2024
