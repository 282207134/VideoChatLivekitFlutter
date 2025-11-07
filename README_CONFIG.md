# LiveKit 配置说明

## 已创建的配置文件

1. **`lib/config/livekit_config.dart`** - 直接使用常量配置（推荐用于开发）
2. **`lib/config/env_config.dart`** - 支持环境变量的配置类

## 快速开始

### 方式 1: 使用常量配置（最简单）

直接使用 `LiveKitConfig` 类：

```dart
import 'package:your_app/config/livekit_config.dart';

// 获取配置
final url = LiveKitConfig.url;
final apiKey = LiveKitConfig.apiKey;
final apiSecret = LiveKitConfig.apiSecret;
```

### 方式 2: 使用环境变量

1. **手动创建 `.env` 文件**（在项目根目录）：
   ```
   LIVEKIT_URL=wss://dome-qtf8hjw3.livekit.cloud
   LIVEKIT_API_KEY=APIsb4WTHUoSfHb
   LIVEKIT_API_SECRET=p9R0O4ikR9CTj9CtHvd3jWkDxrVmZzp7FqrYOphQjtG
   ```

2. **在 `pubspec.yaml` 中添加依赖**：
   ```yaml
   dependencies:
     flutter_dotenv: ^5.1.0
   ```

3. **在 `pubspec.yaml` 的 `flutter` 部分添加**：
   ```yaml
   flutter:
     assets:
       - .env
   ```

4. **在 `main.dart` 中初始化**：
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';
   import 'package:your_app/config/env_config.dart';
   
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await dotenv.load(fileName: ".env");
     runApp(MyApp());
   }
   ```

5. **使用配置**：
   ```dart
   import 'package:your_app/config/env_config.dart';
   
   final url = EnvConfig.liveKitUrl;
   final apiKey = EnvConfig.liveKitApiKey;
   final apiSecret = EnvConfig.liveKitApiSecret;
   ```

## 当前配置值

- **URL**: `wss://dome-qtf8hjw3.livekit.cloud`
- **API Key**: `APIsb4WTHUoSfHb`
- **API Secret**: `p9R0O4ikR9CTj9CtHvd3jWkDxrVmZzp7FqrYOphQjtG`

## 安全提示

- ⚠️ `.env` 文件已添加到 `.gitignore`，不会被提交到版本控制
- ⚠️ 生产环境建议使用更安全的密钥管理方式
- ⚠️ 不要将 API Secret 硬编码在代码中（当前配置仅用于开发测试）

