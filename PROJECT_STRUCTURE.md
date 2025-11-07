# Project Structure Overview

## Directory Tree

```
livekit-flutter-video-call/
├── android/                          # Android platform code
│   ├── app/
│   │   ├── build.gradle             # Android app build configuration
│   │   └── src/main/
│   │       ├── AndroidManifest.xml  # Android app manifest
│   │       └── kotlin/
│   │           └── com/livekit/videocall/
│   │               └── MainActivity.kt
│   └── build.gradle                 # Android root build configuration
├── ios/                             # iOS platform code
│   ├── Runner/
│   │   ├── Info.plist              # iOS app configuration
│   │   └── Assets.xcassets/        # iOS app icons and images
│   ├── Podfile                      # CocoaPods configuration
│   └── Runner.xcworkspace/          # Xcode workspace
├── lib/                             # Dart/Flutter code (main source)
│   ├── main.dart                   # App entry point
│   ├── screens/                    # UI screens
│   │   ├── home_screen.dart        # Home screen (room join)
│   │   └── call_screen.dart        # Active call screen
│   ├── services/                   # Business logic services
│   │   └── livekit_service.dart    # LiveKit SDK wrapper
│   ├── widgets/                    # Reusable UI components
│   │   ├── participant_widget.dart # Individual participant tile
│   │   └── room_input_dialog.dart  # Room details input dialog
│   └── utils/                      # Utility functions
│       ├── app_config.dart         # App configuration constants
│       └── permission_helper.dart  # Permission handling utilities
├── test/                           # Unit and widget tests
│   ├── services/
│   │   └── livekit_service_test.dart
│   └── widgets/
│       └── participant_widget_test.dart
├── build/                          # Build output (git ignored)
├── .git/                           # Git repository
├── .gitignore                      # Git ignore rules
├── pubspec.yaml                    # Flutter dependencies and configuration
├── pubspec.lock                    # Locked dependency versions
├── README.md                       # User-facing documentation
├── DEPLOYMENT.md                   # Comprehensive deployment guide
├── SETUP_GUIDE.md                  # Development environment setup
├── OPTIONAL_FEATURES.md            # Firebase and optional features
├── PROJECT_STRUCTURE.md            # This file
├── analysis_options.yaml           # Dart analyzer configuration
└── LICENSE                         # MIT License

```

## File Descriptions

### Core Application Files

#### `lib/main.dart`
- **Purpose**: Application entry point
- **Contains**:
  - `MyApp` class - Root widget
  - App theme configuration
  - Route definitions
  - Material Design 3 setup
- **Key Functions**:
  - `runApp()` - Start the application
  - Route navigation setup

#### `lib/screens/home_screen.dart`
- **Purpose**: Initial screen for joining a video call room
- **Contains**:
  - Room join form
  - Permission request handling
  - Navigation to call screen
- **Features**:
  - Input validation
  - Loading state management
  - Error handling

#### `lib/screens/call_screen.dart`
- **Purpose**: Main video call interface
- **Contains**:
  - Participant video grid
  - Call control buttons
  - Audio/video toggle functionality
- **Features**:
  - Real-time participant updates
  - Responsive layout
  - Call end handling

#### `lib/services/livekit_service.dart`
- **Purpose**: LiveKit SDK wrapper and abstraction
- **Contains**:
  - Room connection management
  - Participant tracking
  - Media stream handling
- **Key Methods**:
  - `connect()` - Join a room
  - `disconnect()` - Leave a room
  - `toggleMicrophone()` - Mute/unmute
  - `toggleCamera()` - Camera control

#### `lib/widgets/participant_widget.dart`
- **Purpose**: Individual participant video display
- **Contains**:
  - RTCVideoView for video rendering
  - Participant name display
  - Microphone status indicator
- **Features**:
  - Real-time video streaming
  - Status updates

#### `lib/widgets/room_input_dialog.dart`
- **Purpose**: Dialog for room connection details
- **Contains**:
  - Server URL input
  - JWT token input
  - Room name input
- **Features**:
  - Input validation
  - Error messages

#### `lib/utils/app_config.dart`
- **Purpose**: Application configuration constants
- **Contains**:
  - App version and build info
  - LiveKit settings
  - UI configuration
  - Timeout values

#### `lib/utils/permission_helper.dart`
- **Purpose**: Platform permission handling
- **Contains**:
  - Camera permission requests
  - Microphone permission requests
  - Permission status checking
  - Settings navigation

### Android Platform Files

#### `android/AndroidManifest.xml`
- Declares app permissions
- Specifies required features
- Defines activities and intent filters
- Permissions: INTERNET, CAMERA, RECORD_AUDIO, etc.

#### `android/app/build.gradle`
- Android build configuration
- SDK versions and dependencies
- Signing configuration
- Build types (debug/release)

#### `android/MainActivity.kt`
- Android activity entry point
- Flutter integration setup
- Platform channel implementation (if needed)

### iOS Platform Files

#### `ios/Runner/Info.plist`
- iOS app configuration
- Permission descriptions
- Device orientation settings
- Feature declarations

#### `ios/Podfile`
- CocoaPods dependencies
- iOS build settings
- Swift and iOS version requirements

### Configuration Files

#### `pubspec.yaml`
- Flutter project manifest
- Dart dependencies:
  - `livekit_client` - LiveKit SDK
  - `permission_handler` - Permission management
  - `cupertino_icons` - iOS icons
  - `intl` - Internationalization
- Flutter settings:
  - Material design enabled
  - Assets configuration

#### `pubspec.lock`
- Locked dependency versions
- Ensures reproducible builds
- Auto-generated by `flutter pub get`

#### `.gitignore`
- Files to exclude from version control
- Generated files
- Build outputs
- IDE configurations
- OS-specific files

### Documentation Files

#### `README.md`
- Project overview
- Features list
- Quick start guide
- Usage instructions
- Deployment links
- Troubleshooting
- Resource links

#### `DEPLOYMENT.md`
- Prerequisites and system requirements
- Android deployment guide
- iOS deployment guide
- Google Play Store deployment
- Apple App Store deployment
- LiveKit server setup
- Token generation guide
- Testing procedures
- Troubleshooting guide

#### `SETUP_GUIDE.md`
- Development environment setup
- Flutter installation
- IDE configuration
- Android setup (emulator/device)
- iOS setup (simulator/device)
- LiveKit account setup
- Development workflow
- Debugging tips

#### `OPTIONAL_FEATURES.md`
- Firebase integration
- Analytics setup
- Crash reporting
- Push notifications
- Backend server examples
- Security best practices
- Performance optimization

#### `PROJECT_STRUCTURE.md`
- This file
- Directory structure overview
- File descriptions
- Development guidelines

### Build Outputs (git ignored)

#### `build/`
- Compiled app packages
- Generated code
- Build artifacts
- Platform-specific outputs

#### `.dart_tool/`
- Dart analyzer cache
- Generated files
- Flutter tool data

---

## Development Workflow

### 1. Project Setup
```
├── Clone repository
├── flutter pub get
├── cd android && ./gradlew clean && cd ..
├── cd ios && pod install && cd ..
└── flutter run
```

### 2. Feature Development
```
├── Create feature branch
├── Edit files in lib/
├── Hot reload (press 'r')
├── Test changes
├── Commit changes
└── Push to repository
```

### 3. Building Release
```
├── flutter build apk --release
├── flutter build appbundle --release (Android)
├── flutter build ios --release (iOS)
└── Deploy to stores
```

---

## Code Organization Principles

### Separation of Concerns
- **Screens**: UI and user interaction
- **Services**: Business logic and SDK integration
- **Widgets**: Reusable UI components
- **Utils**: Helper functions and configuration

### Naming Conventions
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Methods/Variables**: `camelCase`
- **Constants**: `camelCase` (private) or `UPPER_CASE` (public)

### Import Organization
1. Dart imports
2. Flutter imports
3. Package imports (alphabetical)
4. Relative imports (alphabetical)

### File Organization
- Imports at top
- Class/function definitions
- Private methods at bottom
- Dispose/cleanup at end

---

## Adding New Features

### Adding a New Screen

1. Create `lib/screens/new_screen.dart`
2. Extend `StatefulWidget` or `StatelessWidget`
3. Implement `build()` method
4. Add route in `main.dart`
5. Update navigation

### Adding a New Service

1. Create `lib/services/new_service.dart`
2. Create singleton pattern (optional)
3. Implement required methods
4. Add error handling
5. Update dependents

### Adding a New Widget

1. Create `lib/widgets/new_widget.dart`
2. Accept required parameters
3. Implement `build()` method
4. Document purpose and usage
5. Add to other widgets if needed

---

## Testing Structure

### Unit Tests
```
test/
├── services/
│   └── livekit_service_test.dart
├── utils/
│   └── permission_helper_test.dart
└── ...
```

### Widget Tests
```
test/
├── widgets/
│   ├── participant_widget_test.dart
│   └── room_input_dialog_test.dart
└── ...
```

### Integration Tests
```
test_driver/
├── app.dart                    # Test app
└── app_test.dart              # Test scenarios
```

---

## Performance Considerations

### Memory Management
- Dispose resources in `dispose()` methods
- Cancel stream subscriptions
- Clear large data structures
- Use `StreamBuilder` for efficient rebuilds

### Build Performance
- Use `const` constructors
- Avoid rebuilding entire widgets
- Use `ValueKey` for list items
- Implement `shouldRebuild()` in providers

### Network Optimization
- Use adaptive streaming
- Implement connection retry logic
- Handle network state changes
- Compress media when possible

---

## Security Considerations

### Data Protection
- Don't store sensitive tokens locally
- Use secure storage for credentials
- Clear sensitive data on logout
- Validate all user inputs

### API Security
- Use HTTPS/WSS in production
- Implement token expiration
- Validate JWT tokens
- Implement rate limiting

### Permission Safety
- Request only needed permissions
- Explain why permissions are needed
- Handle permission denials gracefully
- Respect user privacy

---

## Debugging Tips

### Common Debugging Locations

#### For UI Issues
- `lib/screens/*.dart` - Layout and structure
- `lib/widgets/*.dart` - Component rendering
- `pubspec.yaml` - Dependencies and assets

#### For Logic Issues
- `lib/services/*.dart` - Business logic
- `lib/utils/*.dart` - Helper functions
- `main.dart` - App routing and configuration

#### For Build Issues
- `pubspec.yaml` - Dependency conflicts
- `android/build.gradle` - Android configuration
- `ios/Podfile` - iOS dependencies

---

## Next Steps

1. **Read README.md** for user overview
2. **Follow SETUP_GUIDE.md** for environment setup
3. **Review DEPLOYMENT.md** for app deployment
4. **Check OPTIONAL_FEATURES.md** for enhancements
5. **Start developing** following conventions above

---

**Last Updated**: 2024
