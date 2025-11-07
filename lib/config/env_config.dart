// 注意：使用此配置类需要先安装 flutter_dotenv 包
// 在 pubspec.yaml 中添加: flutter_dotenv: ^5.1.0
// 并在 pubspec.yaml 的 flutter.assets 中添加: - .env

class EnvConfig {
  // 默认配置值（如果未使用 flutter_dotenv）
  static const String _defaultUrl = 'wss://dome-qtf8hjw3.livekit.cloud';
  static const String _defaultApiKey = 'APIsb4WTHUoSfHb';
  static const String _defaultApiSecret = 'p9R0O4ikR9CTj9CtHvd3jWkDxrVmZzp7FqrYOphQjtG';
  
  // LiveKit WebSocket URL
  static String get liveKitUrl {
    // 如果使用 flutter_dotenv，取消下面的注释
    // return dotenv.env['LIVEKIT_URL'] ?? _defaultUrl;
    return _defaultUrl;
  }
  
  // LiveKit API Key
  static String get liveKitApiKey {
    // 如果使用 flutter_dotenv，取消下面的注释
    // return dotenv.env['LIVEKIT_API_KEY'] ?? _defaultApiKey;
    return _defaultApiKey;
  }
  
  // LiveKit API Secret
  static String get liveKitApiSecret {
    // 如果使用 flutter_dotenv，取消下面的注释
    // return dotenv.env['LIVEKIT_API_SECRET'] ?? _defaultApiSecret;
    return _defaultApiSecret;
  }
  
  // 初始化环境变量（如果使用 flutter_dotenv，取消注释）
  // static Future<void> load() async {
  //   await dotenv.load(fileName: ".env");
  // }
}

