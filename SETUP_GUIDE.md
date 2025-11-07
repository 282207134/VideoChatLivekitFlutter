# LiveKit Flutter Video Call - Development Setup Guide

This guide provides step-by-step instructions for setting up the development environment.

## Prerequisites

### System Requirements

- **RAM**: 8 GB minimum (16 GB recommended)
- **Storage**: 15 GB free space minimum
- **OS**: macOS, Linux, or Windows
- **Internet**: Stable connection for downloading SDKs

### Supported Operating Systems

- macOS 10.15+
- Ubuntu 20.04+
- Windows 10 or 11

## Step 1: Install Flutter

### macOS

```bash
# Using Homebrew (recommended)
brew install flutter

# Or download manually from https://flutter.dev/docs/get-started/install/macos

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### Ubuntu/Linux

```bash
# Install dependencies
sudo apt-get install git curl unzip xz-utils zip libglu1-mesa

# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### Windows

```bash
# Download from https://flutter.dev/docs/get-started/install/windows
# Extract to C:\src\flutter
# Add C:\src\flutter\bin to PATH environment variable
```

### Verify Installation

```bash
flutter doctor -v
```

Expected output:
```
[✓] Flutter (Channel stable, 3.10.0, on macOS, darwin-arm64)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS
[✓] Android Studio (version 2022.x.x)
[✓] VS Code (version 1.x.x)
[✓] Connected device (1 available)
```

## Step 2: Install IDE

### Option A: Android Studio (Recommended)

1. Download from https://developer.android.com/studio
2. Run installer and follow setup wizard
3. Install Flutter and Dart plugins:
   - Open Android Studio
   - Settings → Plugins
   - Search "Flutter" → Install
   - Search "Dart" → Install
4. Restart Android Studio

### Option B: Visual Studio Code

```bash
# Install VS Code
# macOS: brew install --cask visual-studio-code
# Or download from https://code.visualstudio.com

# Install extensions
# - Flutter (id: Dart-Code.flutter)
# - Dart (id: Dart-Code.dart-code)
```

### Option C: IntelliJ IDEA

1. Download from https://www.jetbrains.com/idea/
2. Install Flutter and Dart plugins from marketplace
3. Configure Flutter SDK path

## Step 3: Clone Project

```bash
# Clone the repository
git clone <repository-url>
cd livekit-flutter-video-call

# Verify on correct branch
git checkout feat/livekit-flutter-video-call-deploy-docs
```

## Step 4: Install Dependencies

```bash
# Get all Dart packages
flutter pub get

# Resolve Android dependencies
cd android
./gradlew clean
cd ..

# Resolve iOS dependencies
cd ios
pod install --repo-update
cd ..
```

## Step 5: Android Setup

### Install Android SDK

Using Android Studio:
1. Open Android Studio
2. Tools → SDK Manager
3. Install:
   - Android SDK 33+ (API level 33)
   - Build Tools 34+
   - SDK Platform-Tools
   - Intel x86 Emulator Accelerator (HAXM) or KVM

### Create Android Emulator

```bash
# List available emulators
flutter emulators

# Create new emulator
flutter emulators create --name "Pixel_4_API_33"

# Launch emulator
flutter emulators --launch "Pixel_4_API_33"

# Or using Android Studio:
# Tools → Device Manager → Create Device
```

### Android Virtual Device (AVD) Configuration

1. Open Android Studio
2. Tools → Device Manager
3. Create Virtual Device
4. Select device (Pixel 4 recommended)
5. Select Android version (API 33+)
6. Configure:
   - RAM: 2048 MB
   - VM Heap: 512 MB
   - Internal Storage: 2 GB
   - SD Card: 100 MB

## Step 6: iOS Setup (macOS Only)

### Install Xcode Command Line Tools

```bash
xcode-select --install
```

### Install CocoaPods

```bash
sudo gem install cocoapods
```

### Configure iOS Deployment

```bash
# Open iOS project in Xcode
open ios/Runner.xcworkspace

# Or configure via command line
# In Xcode:
# - Select Runner project
# - Select Runner target
# - Build Settings:
#   - Minimum Deployments: 11.0
#   - Development Team: Select your team
```

### Create iOS Simulator

```bash
# List available simulators
xcrun xctrace list devices

# Create simulator
xcrun simctl create "iPhone 14" \
  "com.apple.CoreSimulator.SimDeviceType.iPhone-14" \
  "com.apple.CoreSimulator.SimRuntime.iOS-17-4"

# Launch simulator
xcrun simctl boot <device-uuid>
open /Applications/Simulator.app
```

## Step 7: LiveKit Setup

### Get LiveKit Cloud Account

1. Visit https://cloud.livekit.io
2. Sign up for free account
3. Create new project
4. Copy credentials:
   - API Key
   - API Secret
   - WebRTC URL (e.g., `wss://your-project.livekit.cloud`)

### Generate Test Token

Create `scripts/generate_token.js`:

```javascript
const { AccessToken } = require("livekit-server-sdk");

const apiKey = process.env.LIVEKIT_API_KEY || "your_api_key";
const apiSecret = process.env.LIVEKIT_API_SECRET || "your_api_secret";

const at = new AccessToken(apiKey, apiSecret);
at.identity = "test-user";
at.name = "Test User";
at.addGrant({
  roomJoin: true,
  room: "test-room",
  canPublish: true,
  canPublishData: true,
  canSubscribe: true,
});

console.log(at.toJwt());
```

Run:

```bash
npm install livekit-server-sdk
node scripts/generate_token.js
```

## Step 8: Configure Environment

### Create .env File (Optional)

```bash
# .env (git ignored)
LIVEKIT_URL=wss://your-project.livekit.cloud
LIVEKIT_API_KEY=your_api_key
LIVEKIT_API_SECRET=your_api_secret
```

### Update Configuration

Edit `lib/utils/app_config.dart`:

```dart
class AppConfig {
  static const String defaultLiveKitUrl = 'wss://your-project.livekit.cloud';
  // ... other config
}
```

## Step 9: Run the App

### First Run

```bash
# Ensure emulator/device is running
flutter devices

# Run app
flutter run
```

### Debug Mode

```bash
# Run in debug mode with verbose output
flutter run -v

# Debug with DevTools
flutter run --devtools
```

### Release Mode

```bash
# Build and run release version
flutter run --release
```

## Step 10: Testing

### Unit Tests

```bash
# Run all unit tests
flutter test

# Run specific test file
flutter test test/services/livekit_service_test.dart

# Run with coverage
flutter test --coverage
```

### Widget Tests

```bash
# Run widget tests
flutter test test/widgets/
```

### Integration Tests

```bash
# Run integration tests
flutter drive --target=test_driver/app.dart
```

## Step 11: Code Quality

### Formatting

```bash
# Format all Dart files
dart format .

# Or using flutter
flutter format .
```

### Linting

```bash
# Analyze code
flutter analyze

# Fix issues automatically
dart fix --apply
```

### Type Checking

```bash
# Check types
dart analyze
```

## Troubleshooting

### Flutter Doctor Issues

```bash
# Get detailed diagnosis
flutter doctor -v

# Accept licenses
flutter doctor --android-licenses

# Download SDK
flutter precache
```

### Gradle Build Issues

```bash
# Clean gradle cache
cd android
./gradlew clean
./gradlew --stop
cd ..
flutter clean
flutter pub get
```

### Pod Installation Issues

```bash
# Clean pods
cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install --repo-update
cd ..
```

### Emulator Issues

```bash
# Restart emulator
flutter clean
adb kill-server
adb start-server
flutter run
```

### iOS Build Issues

```bash
# Clean build
flutter clean
cd ios
rm -rf Pods DerivedData
pod install --repo-update
cd ..
flutter pub get
flutter run
```

## IDE Configuration

### VS Code Extensions

Recommended extensions in `.vscode/extensions.json`:

```json
{
  "recommendations": [
    "Dart-Code.flutter",
    "Dart-Code.dart-code",
    "esbenp.prettier-vscode",
    "bradlc.vscode-tailwindcss"
  ]
}
```

### VS Code Settings

Create `.vscode/settings.json`:

```json
{
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "Dart-Code.dart"
  },
  "dart.flutterSdkPath": "/path/to/flutter",
  "dart.analysisExcludedFolders": [
    "ios",
    "android",
    "build"
  ]
}
```

### Android Studio Configuration

Recommended settings:
- Editor → Code Style → Dart: Enable "Format code on save"
- Plugins: Install Flutter and Dart plugins
- Languages & Frameworks → Dart: Set Dart SDK path

## Development Workflow

### Daily Development

```bash
# Start development
1. Launch emulator/connect device: `flutter devices`
2. Start hot reload: `flutter run`
3. Make code changes
4. Press 'r' to hot reload
5. Press 'R' to hot restart
6. Test changes
```

### Version Control

```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes and commit
git add .
git commit -m "feat: add my feature"

# Push to repository
git push origin feature/my-feature

# Create pull request on GitHub
```

### Building for Release

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## Performance Profiling

### Enable Performance Monitoring

```bash
# Run with profiling
flutter run --profile

# Or use DevTools
flutter pub global activate devtools
devtools
```

### Analyze Performance

In DevTools:
1. Open Performance view
2. Record timeline
3. Perform actions
4. Analyze frame rate and CPU usage

## Debugging

### Print Debugging

```dart
print('Debug: $variable');
debugPrint('Debug output');
```

### Debugger

```bash
# Run with debugger
flutter run

# Set breakpoints in IDE
# Press 'd' to detach, 'q' to quit
```

### Hot Reload/Restart

```bash
# During flutter run:
# 'r' - hot reload (fast, preserves state)
# 'R' - hot restart (full restart)
# 'p' - toggle performance overlay
# 'o' - toggle orientation
# 'q' - quit
```

## Next Steps

1. Read [README.md](./README.md) for app overview
2. Review [DEPLOYMENT.md](./DEPLOYMENT.md) for deployment
3. Check [pubspec.yaml](./pubspec.yaml) for dependencies
4. Explore [lib/](./lib) directory structure

## Additional Resources

- **Flutter Setup**: https://flutter.dev/docs/get-started/install
- **Dart Language**: https://dart.dev/guides
- **LiveKit Docs**: https://docs.livekit.io
- **Android Studio**: https://developer.android.com/studio
- **Xcode**: https://developer.apple.com/xcode

## Getting Help

1. Check Flutter docs: https://flutter.dev/docs
2. Search Stack Overflow with tags: `flutter` + `livekit`
3. Open GitHub issues: https://github.com/livekit/client-sdk-flutter/issues
4. Join Flutter Discord: https://discord.gg/N7Yshp27x5

---

**Last Updated**: 2024
