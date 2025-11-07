# LiveKit Flutter 视频通话 - 开发环境搭建指南

本文档提供搭建开发环境的分步说明。

## 前置条件

### 硬件与系统要求

- **内存**：至少 8 GB（推荐 16 GB）
- **储存空间**：至少 15 GB 可用空间
- **操作系统**：macOS、Linux 或 Windows
- **网络**：稳定的互联网连接用于下载 SDK

### 支持的操作系统

- macOS 10.15 及以上
- Ubuntu 20.04 及以上
- Windows 10 或 11

## 步骤 1：安装 Flutter

### macOS

```bash
# 推荐使用 Homebrew
brew install flutter

# 或从 https://flutter.dev/docs/get-started/install/macos 手动下载

# 添加 Flutter 到 PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### Ubuntu/Linux

```bash
# 安装依赖
sudo apt-get install git curl unzip xz-utils zip libglu1-mesa

# 下载 Flutter
git clone https://github.com/flutter/flutter.git -b stable

# 添加到 PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### Windows

```bash
# 从 https://flutter.dev/docs/get-started/install/windows 下载
# 解压至 C:\src\flutter
# 将 C:\src\flutter\bin 加入环境变量 PATH
```

### 验证安装

```bash
flutter doctor -v
```

期望输出：
```
[✓] Flutter (Channel stable, 3.10.0, on macOS, darwin-arm64)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS
[✓] Android Studio (version 2022.x.x)
[✓] VS Code (version 1.x.x)
[✓] Connected device (1 available)
```

## 步骤 2：安装 IDE

### 方案 A：Android Studio（推荐）

1. 访问 https://developer.android.com/studio 下载
2. 按向导完成安装
3. 安装 Flutter 与 Dart 插件：
   - 打开 Android Studio
   - Settings → Plugins
   - 搜索 “Flutter” 并安装
   - 搜索 “Dart” 并安装
4. 重启 Android Studio

### 方案 B：Visual Studio Code

```bash
# 安装 VS Code
# macOS：brew install --cask visual-studio-code
# 或访问 https://code.visualstudio.com 下载

# 安装扩展
# - Flutter (id: Dart-Code.flutter)
# - Dart (id: Dart-Code.dart-code)
```

### 方案 C：IntelliJ IDEA

1. 下载：https://www.jetbrains.com/idea/
2. 在 Marketplace 中安装 Flutter 与 Dart 插件
3. 配置 Flutter SDK 路径

## 步骤 3：克隆项目

```bash
# 克隆仓库
git clone <repository-url>
cd livekit-flutter-video-call

# 确认位于指定分支
git checkout docs-translate-zh-cn
```

## 步骤 4：安装依赖

```bash
# 获取 Dart 包
flutter pub get

# 解决 Android 依赖
cd android
./gradlew clean
cd ..

# 解决 iOS 依赖
cd ios
pod install --repo-update
cd ..
```

## 步骤 5：Android 环境配置

### 安装 Android SDK

通过 Android Studio：
1. 打开 Android Studio
2. Tools → SDK Manager
3. 安装以下组件：
   - Android SDK 33+（API 级别 33）
   - Build Tools 34+
   - SDK Platform-Tools
   - Intel x86 Emulator Accelerator (HAXM) 或 KVM

### 创建 Android 模拟器

```bash
# 查看已存在的模拟器
flutter emulators

# 创建新模拟器
flutter emulators create --name "Pixel_4_API_33"

# 启动模拟器
flutter emulators --launch "Pixel_4_API_33"

# 或在 Android Studio 中：Tools → Device Manager → Create Device
```

### AVD 配置建议

1. 打开 Android Studio
2. Tools → Device Manager
3. 创建虚拟设备
4. 推荐选择 Pixel 4
5. Android 版本：API 33+
6. 参数建议：
   - RAM：2048 MB
   - VM Heap：512 MB
   - 内部存储：2 GB
   - SD 卡：100 MB

## 步骤 6：iOS 环境配置（仅限 macOS）

### 安装 Xcode 命令行工具

```bash
xcode-select --install
```

### 安装 CocoaPods

```bash
sudo gem install cocoapods
```

### 配置 iOS 项目

```bash
# 在 Xcode 中打开项目
open ios/Runner.xcworkspace

# 或在 Xcode 中执行以下操作：
# - 选择 Runner 工程
# - 选择 Runner target
# - Build Settings：
#   - Minimum Deployments: 11.0
#   - Development Team: 选择你的团队
```

### 创建 iOS 模拟器

```bash
# 查看可用设备
xcrun xctrace list devices

# 创建模拟器
xcrun simctl create "iPhone 14" \
  "com.apple.CoreSimulator.SimDeviceType.iPhone-14" \
  "com.apple.CoreSimulator.SimRuntime.iOS-17-4"

# 启动模拟器
xcrun simctl boot <device-uuid>
open /Applications/Simulator.app
```

## 步骤 7：配置 LiveKit

### 获取 LiveKit Cloud 账号

1. 访问 https://cloud.livekit.io
2. 注册免费账号
3. 创建新项目
4. 获取以下信息：
   - API Key
   - API Secret
   - WebRTC URL（例如 `wss://your-project.livekit.cloud`）

### 生成测试令牌

创建 `scripts/generate_token.js`：

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

运行：

```bash
npm install livekit-server-sdk
node scripts/generate_token.js
```

## 步骤 8：配置环境变量

### 8.1 复制示例文件

```bash
cp .env.example .env
# 根据环境修改 LIVEKIT_URL/LIVEKIT_API_KEY/LIVEKIT_API_SECRET
```

> `.env.example` 中已经预置了可直接使用的 LiveKit Cloud 凭据，未创建 `.env` 时应用会自动回退到这些默认值。

### 8.2 通过 Dart Define 注入

```bash
flutter run --dart-define-from-file=.env
# 或者在构建时：flutter build apk --dart-define-from-file=.env
```

> `flutter run` / `flutter build` 支持多个 `--dart-define` 参数，必要时可以覆盖单个键值。

### 8.3 更新应用配置

`lib/utils/app_config.dart` 会自动从 `LIVEKIT_URL`、`LIVEKIT_API_KEY` 与 `LIVEKIT_API_SECRET` 读取值，未定义时回退到仓库内置默认配置。

## 步骤 9：运行应用

### 首次运行

```bash
# 确保设备或模拟器已就绪
flutter devices

# 启动应用
flutter run
```

### 调试模式

```bash
# 使用详细日志运行
flutter run -v

# 启动 DevTools
flutter run --devtools
```

### 发布模式

```bash
# 构建并运行发布版本
flutter run --release
```

## 步骤 10：执行测试

### 单元测试

```bash
# 运行所有单元测试
flutter test

# 运行指定测试文件
flutter test test/services/livekit_service_test.dart

# 生成覆盖率
flutter test --coverage
```

### Widget 测试

```bash
# 运行 widget 测试
flutter test test/widgets/
```

### 集成测试

```bash
# 运行集成测试
flutter drive --target=test_driver/app.dart
```

## 步骤 11：代码质量

### 代码格式化

```bash
# 格式化所有 Dart 文件
dart format .

# 或使用 flutter
flutter format .
```

### Lint 检查

```bash
# 静态分析
flutter analyze

# 自动修复
dart fix --apply
```

### 类型检查

```bash
# 运行类型分析
dart analyze
```

## 故障排查

### Flutter Doctor 问题

```bash
# 获取详细信息
flutter doctor -v

# 接受许可协议
flutter doctor --android-licenses

# 预下载 SDK
flutter precache
```

### Gradle 构建问题

```bash
# 清理 Gradle 缓存
cd android
./gradlew clean
./gradlew --stop
cd ..
flutter clean
flutter pub get
```

### Pod 安装问题

```bash
# 清理 Pods
cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install --repo-update
cd ..
```

### 模拟器问题

```bash
# 重启模拟器
flutter clean
adb kill-server
adb start-server
flutter run
```

### iOS 构建问题

```bash
# 清理并重新安装依赖
flutter clean
cd ios
rm -rf Pods DerivedData
pod install --repo-update
cd ..
flutter pub get
flutter run
```

## IDE 配置建议

### VS Code 扩展

在 `.vscode/extensions.json` 中推荐以下扩展：

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

### VS Code 设置

创建 `.vscode/settings.json`：

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

### Android Studio 设置

推荐配置：
- Editor → Code Style → Dart：开启“保存时格式化”
- 插件：安装 Flutter 与 Dart
- Languages & Frameworks → Dart：设置 Dart SDK 路径

## 开发流程

### 日常开发

```bash
1. 启动模拟器或连接设备：flutter devices
2. 启动热重载：flutter run
3. 修改代码
4. 按 'r' 进行热重载
5. 按 'R' 进行热重启
6. 测试变更
```

### 版本控制

```bash
# 创建功能分支
git checkout -b feature/my-feature

# 修改并提交
git add .
git commit -m "feat: add my feature"

# 推送到远端
git push origin feature/my-feature

# 在 GitHub 上创建 Pull Request
```

### 发布构建

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 性能分析

### 启用性能监控

```bash
# 以性能模式运行
flutter run --profile

# 或启用 DevTools
flutter pub global activate devtools
devtools
```

### 分析性能

在 DevTools 中：
1. 打开 Performance 视图
2. 开始记录时间轴
3. 在应用中执行操作
4. 分析帧率与 CPU 使用情况

## 调试技巧

### 打印调试

```dart
print('Debug: $variable');
debugPrint('Debug output');
```

### 调试器

```bash
# 启动调试
flutter run

# 在 IDE 中设置断点
# 终端快捷键：'d' 分离调试，'q' 退出
```

### 热重载 / 热重启

```bash
# 在 flutter run 期间可用：
# 'r' - 热重载（快速，保留状态）
# 'R' - 热重启（完全重启）
# 'p' - 切换性能叠层
# 'o' - 切换横竖屏
# 'q' - 退出
```

## 下一步

1. 阅读 [README.md](./README.md) 了解应用概览
2. 查阅 [DEPLOYMENT.md](./DEPLOYMENT.md) 准备部署
3. 查看 [pubspec.yaml](./pubspec.yaml) 确认依赖
4. 探索 [lib/](./lib) 目录结构

## 额外资源

- **Flutter 安装指南**：https://flutter.dev/docs/get-started/install
- **Dart 语言**：https://dart.dev/guides
- **LiveKit 文档**：https://docs.livekit.io
- **Android Studio**：https://developer.android.com/studio
- **Xcode**：https://developer.apple.com/xcode

## 获取帮助

1. 查阅 Flutter 文档：https://flutter.dev/docs
2. 在 Stack Overflow 使用 `flutter` 和 `livekit` 标签搜索
3. 在 GitHub 提交 Issue：https://github.com/livekit/client-sdk-flutter/issues
4. 加入 Flutter Discord：https://discord.gg/N7Yshp27x5

---

**最后更新**：2024
