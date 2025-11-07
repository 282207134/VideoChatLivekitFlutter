# LiveKit Flutter 视频通话 - 部署指南

这是一份涵盖 LiveKit Flutter 视频通话应用在 Android 与 iOS 平台上部署流程的完整指南。

## 目录

1. [前置条件](#前置条件)
2. [项目初始化](#项目初始化)
3. [Android 部署](#android-部署)
4. [iOS 部署](#ios-部署)
5. [LiveKit 服务器配置](#livekit-服务器配置)
6. [测试](#测试)
7. [故障排查](#故障排查)

---

## 前置条件

在开始部署之前，请确保已经安装以下工具：

### 必需软件

- **Flutter SDK**：版本不低于 3.10.0  
  下载地址：https://flutter.dev/docs/get-started/install

- **Dart SDK**：版本不低于 3.0.0（随 Flutter 一同安装）

- **Git**：版本不低于 2.0

### 平台相关要求

#### Android 环境
- **Android SDK**：API 级别 21 或以上
- **Android Studio**：最新版本，并安装 Android SDK 工具
- **Java Development Kit (JDK)**：版本 11 或以上
- **Kotlin**：版本 1.6 或以上

#### iOS 环境
- **Xcode**：版本 13.0 或以上
- **CocoaPods**：版本 1.11 或以上
- **iOS 部署目标**：11.0 或以上
- **Swift**：版本 5.0 或以上

### 硬件要求
- **开发设备**：
  - iOS 开发需使用 macOS
  - Android 开发可使用 Windows、macOS 或 Linux
- **测试设备**：
  - Android：运行 Android 5.0+ 的实体机或模拟器
  - iOS：运行 iOS 11.0+ 的实体机或模拟器

---

## 项目初始化

### 1. 克隆仓库

```bash
git clone <repository-url>
cd livekit-flutter-video-call
```

### 2. 安装 Flutter 依赖

```bash
# 安装 Dart 依赖
flutter pub get

# 可选：升级到最新依赖版本
flutter pub upgrade
```

### 3. 验证开发环境

```bash
# 检查 Flutter 环境
flutter doctor

# 期望输出：
# ✓ Flutter (Channel stable, 3.10.0 or higher)
# ✓ Dart (bundled with Flutter)
# ✓ Android toolchain (if targeting Android)
# ✓ Xcode (if targeting iOS)
```

---

## Android 部署

### 1. 配置 Android 项目

#### 设置 Application ID 与名称

编辑 `android/app/build.gradle`：

```gradle
defaultConfig {
    applicationId "com.livekit.videocall"  // 替换为你的唯一 App ID
    minSdkVersion flutter.minSdkVersion     // 通常为 21
    targetSdkVersion flutter.targetSdkVersion
    versionCode 1
    versionName "1.0"
}
```

#### 配置清单权限

`android/app/src/main/AndroidManifest.xml` 已包含必需权限：

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### 2. 构建配置

#### 调试构建

开发与测试阶段使用：

```bash
# 构建调试 APK
flutter build apk --debug

# 输出位置：build/app/outputs/flutter-apk/app-debug.apk
```

#### 发布构建

用于生产环境：

```bash
# 构建优化后的发布 APK
flutter build apk --release

# 输出位置：build/app/outputs/flutter-apk/app-release.apk
```

#### App Bundle（发布到 Google Play 时推荐）

```bash
# 构建适用于 Google Play 的 App Bundle
flutter build appbundle --release

# 输出位置：build/app/outputs/bundle/release/app-release.aab
```

### 3. 签名配置

#### 生成签名密钥

```bash
# 生成新的 keystore（仅需执行一次）
keytool -genkey -v -keystore ~/key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload-key \
  -storepass your_store_password \
  -keypass your_key_password

# Windows：
keytool -genkey -v -keystore %USERPROFILE%\key.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias upload-key
```

#### 配置 Gradle 签名

创建/编辑 `android/key.properties`：

```properties
storeFile=../key.jks
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=upload-key
```

编辑 `android/app/build.gradle`：

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

### 4. 安装到设备或模拟器

#### 使用实体设备

```bash
# 在 Android 设备上启用 USB 调试
# 设置 > 开发者选项 > USB 调试

# 查看已连接设备
flutter devices

# 安装并运行
flutter run -v
```

#### 使用 Android 模拟器

```bash
# 列出可用模拟器
flutter emulators

# 启动模拟器
flutter emulators --launch <emulator_id>

# 在模拟器上运行
flutter run
```

### 5. 发布到 Google Play Store

1. **创建 Google Play 开发者账号**（仅需一次）  
   - 访问：https://play.google.com/console  
   - 支付一次性注册费用（25 美元）  
   - 配置结算账号

2. **创建应用**  
   - 点击“创建应用”  
   - 填写应用名称、语言、类别  
   - 接受相关政策

3. **上传 App Bundle**

```bash
# 构建发布用 App Bundle
flutter build appbundle --release

# 在 Google Play Console 中：
# - 前往“发布”>“正式版”
# - 上传 app-release.aab
# - 填写商店信息
# - 提交审核
```

4. **完善商店信息**  
   - 上传应用截图（至少 2 张，最多 8 张）  
   - 撰写应用介绍  
   - 完成内容分级  
   - 选择目标用户群  
   - 提供隐私政策链接

---

## iOS 部署

### 1. 配置 iOS 项目

#### 更新 Bundle Identifier

```bash
# 在 Xcode 中打开 iOS 项目
open ios/Runner.xcworkspace

# 或通过编辑 ios/Runner.pbxproj，自行修改唯一的 Bundle ID
```

#### 设置 iOS 版本

编辑 `ios/Podfile`：

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

### 2. 安装依赖

```bash
# 安装 iOS 依赖
cd ios
pod install --repo-update
cd ..
```

### 3. 构建配置

#### 调试构建

```bash
# 为模拟器构建
flutter build ios --debug --simulator

# 为真机构建
flutter build ios --debug
```

#### 发布构建

```bash
# 为实体设备构建发布包
flutter build ios --release

# 输出位置：build/ios/iphoneos/Runner.app
```

### 4. 在设备或模拟器上运行

#### 使用 iOS 模拟器

```bash
# 列出可用模拟器
xcrun xctrace list devices

# 在指定模拟器上运行
flutter run -d "iPhone 14"
```

#### 使用实体设备

```bash
# 确认设备已在 Xcode 中受信任
# 查看设备列表
flutter devices

# 安装并运行
flutter run -d <device_id>
```

### 5. 发布到 App Store

#### 前置条件

- Apple 开发者账号（99 美元/年）
- Apple ID
- 可用的描述文件与证书

#### 发布流程

1. **在 App Store Connect 中创建应用**  
   - 访问：https://appstoreconnect.apple.com  
   - 点击“My Apps”  
   - 点击“+”>“New App”  
   - 填写应用信息

2. **准备提交包**

```bash
# 归档应用
open ios/Runner.xcworkspace

# 在 Xcode 中：
# - 选择“Generic iOS Device”作为目标设备
# - 菜单栏选择 Product > Archive
```

3. **上传至 App Store**

```bash
# 可以使用 Xcode 内置上传功能：
# 在 Organizer 中选择 Archive > Distribute App > App Store Connect > Upload
```

4. **完善 App Store 信息**  
   - 上传各尺寸的截图（每种尺寸至少 2 张）  
   - 可选：上传应用预览视频  
   - 填写应用描述  
   - 设置关键词  
   - 选择类别与子类别  
   - 完成内容分级  
   - 指定目标年龄

5. **提交审核**  
   - 在“App Review Information”部分填写联系方式  
   - 提供测试账号或说明  
   - 点击“Submit for Review”

---

## LiveKit 服务器配置

### 1. 创建 LiveKit 账号

1. 访问 https://cloud.livekit.io  
2. 注册账号  
3. 创建新项目  
4. 获取 API Key 与 API Secret

### 2. 生成 JWT 令牌

#### 使用 Node.js

```bash
npm install livekit
```

创建 `generate_token.js`：

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

运行：

```bash
node generate_token.js
```

#### 使用 Python

```bash
pip install livekit
```

创建 `generate_token.py`：

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

运行：

```bash
python generate_token.py
```

### 3. 使用 LiveKit Cloud

1. 前往 https://cloud.livekit.io/projects  
2. 选择你的项目  
3. 复制以下信息：
   - **WebRTC URL**：`wss://your-project.livekit.cloud`
   - **API Key** 与 **API Secret**

### 4. 自建 LiveKit 服务器（可选）

#### 使用 Docker

```bash
# 拉取 LiveKit Docker 镜像
docker pull livekit/livekit-server

# 运行 LiveKit 服务器
docker run -d \
  -p 7880:7880 \
  -p 7881:7881 \
  -p 7882:7882/udp \
  -p 7883:7883/udp \
  -e LIVEKIT_KEYS="API_KEY:API_SECRET" \
  -e LIVEKIT_WEBHOOK_API_KEY="your_webhook_key" \
  livekit/livekit-server
```

#### 使用 Kubernetes

```bash
# 使用 Helm 部署 LiveKit
helm repo add livekit https://helm.livekit.io
helm install livekit livekit/livekit-server \
  --values values.yaml
```

---

## 测试

### 1. 部署前测试

#### 手动测试清单

- [ ] 应用可正常启动且无崩溃
- [ ] 摄像头权限请求正常
- [ ] 麦克风权限请求正常
- [ ] 视频预览显示正常
- [ ] 能够连接 LiveKit 服务器
- [ ] 音频传输正常
- [ ] 视频传输正常
- [ ] 多名参与者可见
- [ ] 麦克风静音/恢复功能正常
- [ ] 摄像头开关功能正常
- [ ] 退出房间/结束通话功能正常
- [ ] 横屏模式可用（如已支持）
- [ ] 网络断开时行为得当
- [ ] 弱网情况下表现稳定

#### 设备测试

在多种设备上测试：

```bash
# 测试不同 Android 版本
flutter run -d <device_1_id>
flutter run -d <device_2_id>

# 测试不同 iOS 版本
flutter run -d "iPhone 14"
flutter run -d "iPhone 13"
```

### 2. 性能测试

#### 性能分析

```bash
# 以性能分析模式运行
flutter run --profile
```

重点监控：
- 内存使用
- CPU 使用率
- 帧率（应维持在 60 FPS）
- 电量消耗

### 3. 网络测试

#### 模拟弱网环境

**Android：**
```bash
# 使用 Android 模拟器的网络限速功能
adb shell settings put global airplane_mode_on 0
adb shell cmd connectivity airplane-mode off

# 或使用 ChromeDevTools 进行 WebRTC 调试
```

**iOS：**
```bash
# 使用 Xcode 的 Network Link Conditioner
# 下载地址：https://additional.download.developer.apple.com
```

---

## 故障排查

### 常见问题

#### 1. Flutter Doctor 报错

**问题**：`flutter doctor` 显示缺少组件

**解决方案**：
```bash
# 安装缺少的组件
flutter doctor --verbose

# 接受 Android 相关许可
flutter config --android-studio-dir="/path/to/android-studio"
flutter doctor --android-licenses
```

#### 2. Android 构建失败

**问题**：出现 `Gradle sync failed` 或 `Build failed`

**解决方案**：
```bash
# 清理构建缓存
flutter clean
rm -rf android/build
rm -rf build

# 重新构建
flutter pub get
flutter build apk --verbose
```

#### 3. iOS Pod 安装失败

**问题**：`pod install` 出现冲突

**解决方案**：
```bash
cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install --repo-update
cd ..
```

#### 4. Android 权限被拒

**问题**：访问摄像头或麦克风时应用崩溃

**解决方案**：
- 在 `AndroidManifest.xml` 中声明相关权限
- 在代码中请求运行时权限
- 在 Android 6.0+ 设备上测试（需动态权限）

#### 5. WebRTC 连接问题

**问题**：无法连接到 LiveKit 服务器

**解决方案**：
- 确认服务器 URL 正确（ws:// 或 wss://）
- 确认 JWT 令牌有效
- 检查防火墙设置
- 确认房间名称匹配
- 查看 LiveKit 服务器日志

#### 6. 摄像头/麦克风不可用

**问题**：通话画面黑屏或无声音

**解决方案**：
```dart
// 检查权限
import 'package:permission_handler/permission_handler.dart';

final cameraStatus = await Permission.camera.request();
final micStatus = await Permission.microphone.request();

print('Camera: ${cameraStatus.isGranted}');
print('Microphone: ${micStatus.isGranted}');
```

#### 7. 内存泄漏

**问题**：长时间通话后应用崩溃

**解决方案**：
```dart
@override
void dispose() {
  // 及时释放资源
  _liveKitService.disconnect();
  super.dispose();
}
```

### 性能优化

#### 1. 代码优化

```dart
// 使用 const 构造函数
const MyWidget()

// 避免重复 rebuild
使用 StreamBuilder 替代 setState

// 合理使用 key
key: ValueKey(participant.sid)
```

#### 2. 安装包体积优化

```bash
# 检查包体积
flutter build apk --release --split-per-abi

# 分析依赖树
flutter pub deps --style=tree

# 启用树摇优化
flutter build apk --split-debug-info
```

#### 3. 网络优化

```dart
// 启用自适应流
RoomOptions(
  adaptiveStream: true,
  dynacast: true,
)
```

---

## 其他资源

### 文档

- **Flutter 官方文档**：https://flutter.dev/docs
- **LiveKit 官方文档**：https://docs.livekit.io
- **LiveKit Flutter SDK**：https://pub.dev/packages/livekit_client

### 支持渠道

- **Flutter Issues**：https://github.com/flutter/flutter/issues
- **LiveKit Issues**：https://github.com/livekit/client-sdk-flutter/issues
- **Stack Overflow**：提问时请使用 `flutter` 与 `livekit` 标签

### 相关工具

- **Android Studio**：https://developer.android.com/studio
- **Xcode**：https://developer.apple.com/xcode
- **Firebase Console**：https://console.firebase.google.com（用于分析与崩溃上报）

---

## 版本历史

- **v1.0.0**（2024）- 首次发布，提供基础视频通话功能

## 许可证

本项目遵循 MIT License。

---

## 参与贡献

如果你发现问题或有改进建议，欢迎：
1. 在 GitHub Issues 提交 Bug 报告
2. 提交包含详细描述的功能需求
3. 提交改进代码的 Pull Request

---

**最后更新**：2024
