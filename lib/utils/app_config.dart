/// Application configuration constants
class AppConfig {
  // App information
  static const String appName = 'LiveKit Video Call';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // LiveKit configuration
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration tokenExpiration = Duration(hours: 24);
  static const String defaultLiveKitUrl =
      'wss://dome-qtf8hjw3.livekit.cloud';
  static const String defaultLiveKitApiKey = 'APIsb4WTHUoSfHb';
  static const String defaultLiveKitApiSecret =
      'p9R0O4ikR9CTj9CtHvd3jWkDxrVmZzp7FqrYOphQjtG';
  static const String liveKitUrl = String.fromEnvironment(
    'LIVEKIT_URL',
    defaultValue: defaultLiveKitUrl,
  );
  static const String liveKitApiKey = String.fromEnvironment(
    'LIVEKIT_API_KEY',
    defaultValue: defaultLiveKitApiKey,
  );
  static const String liveKitApiSecret = String.fromEnvironment(
    'LIVEKIT_API_SECRET',
    defaultValue: defaultLiveKitApiSecret,
  );

  // Video/Audio settings
  static const bool enableAdaptiveStream = true;
  static const bool enableDynacast = true;
  static const bool enableAutoSubscribe = true;

  // UI settings
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Logging
  static const bool enableLogging = true;
  static const bool enableDebugLogging = true;
}
