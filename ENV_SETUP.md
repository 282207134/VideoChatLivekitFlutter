# LiveKit 环境变量配置

## 环境变量

请在项目根目录创建 `.env` 文件，并添加以下内容：

```
LIVEKIT_URL=wss://dome-qtf8hjw3.livekit.cloud
LIVEKIT_API_KEY=APIsb4WTHUoSfHb
LIVEKIT_API_SECRET=p9R0O4ikR9CTj9CtHvd3jWkDxrVmZzp7FqrYOphQjtG
```

## 使用方式

### 方式 1: 使用配置文件（已创建）

项目已包含 `lib/config/livekit_config.dart` 文件，可以直接使用：

```dart
import 'package:your_app/config/livekit_config.dart';

// 使用配置
final url = LiveKitConfig.url;
final apiKey = LiveKitConfig.apiKey;
final apiSecret = LiveKitConfig.apiSecret;
```

### 方式 2: 使用环境变量（需要 flutter_dotenv）

1. 在 `pubspec.yaml` 中添加依赖：
```yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

2. 在 `pubspec.yaml` 的 `flutter` 部分添加资源：
```yaml
flutter:
  assets:
    - .env
```

3. 在代码中加载和使用：
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

await dotenv.load(fileName: ".env");

final url = dotenv.env['LIVEKIT_URL'];
final apiKey = dotenv.env['LIVEKIT_API_KEY'];
final apiSecret = dotenv.env['LIVEKIT_API_SECRET'];
```

## 注意事项

- `.env` 文件不应提交到版本控制系统（已添加到 `.gitignore`）
- 生产环境建议使用更安全的方式管理密钥

