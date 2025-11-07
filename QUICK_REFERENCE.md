# LiveKit Flutter 视频通话 - 开发速查手册

## 5 分钟快速启动

### 1. 搭建开发环境
```bash
# 安装 Flutter（根据操作系统参考 https://flutter.dev/docs/get-started/install ）

# 验证安装
flutter doctor

# 克隆仓库
git clone <repository-url>
cd livekit-flutter-video-call

# 获取依赖
flutter pub get
```

### 2. 获取 LiveKit 凭据
- 访问：https://cloud.livekit.io
- 创建账号与项目
- 记录 WebRTC URL、API Key、API Secret

### 3. 配置环境变量
```bash
cp .env.example .env
# 更新 LIVEKIT_URL/LIVEKIT_API_KEY/LIVEKIT_API_SECRET（如有需要）
```
> 也可直接使用示例文件中的默认 LiveKit Cloud 凭据。

### 4. 生成令牌
```bash
npm install livekit-server-sdk

# 编写 generate_token.js，填入 API Key/Secret，运行后获取 JWT 令牌
```

### 5. 运行应用
```bash
flutter run --dart-define-from-file=.env
```

### 6. 使用应用
- 点击 “Join Room”
- 输入服务器 URL、JWT 令牌、房间名称
- 授予权限
- 开始通话！

---

## 常用命令

### 开发
```bash
flutter run              # 在默认设备上运行
flutter run -d android   # 指定 Android 设备
flutter run -d ios       # 指定 iOS 设备（仅限 macOS）
flutter run --profile    # 性能分析模式
flutter run -v           # 显示详细日志
```

### 构建
```bash
flutter build apk --release           # 生成 Android APK
flutter build appbundle --release     # 生成 Android App Bundle（用于 Google Play）
flutter build ios --release           # 生成 iOS 应用
```

### 维护
```bash
flutter clean           # 清理构建缓存
flutter pub get         # 获取依赖
flutter pub upgrade     # 升级依赖
flutter analyze         # 代码静态检查
dart format .           # 代码格式化
```

---

## 项目结构速览

```
lib/
├── main.dart           → 应用入口与路由
├── screens/
│   ├── home_screen.dart    → 加入房间界面
│   └── call_screen.dart    → 视频通话界面
├── services/
│   └── livekit_service.dart → LiveKit 集成
├── widgets/
│   ├── participant_widget.dart → 参会者视频组件
│   └── room_input_dialog.dart  → 信息输入弹窗
└── utils/
    ├── app_config.dart → 配置
    └── permission_helper.dart → 权限处理

android/               → Android 平台配置
ios/                   → iOS 平台配置
```

---

## 令牌生成示例

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

## 常见问题速解

| 问题 | 解决方案 |
|------|-----------|
| `flutter doctor` 报错 | 运行 `flutter doctor --android-licenses` |
| 构建失败 | 执行 `flutter clean && flutter pub get` |
| iOS Pod 冲突 | `cd ios && rm -rf Pods && pod install --repo-update && cd ..` |
| 无法连接 | 确认 URL 使用 ws:// 或 wss://，检查令牌 |
| 黑屏 | 检查摄像头权限，重启应用 |
| 无声音 | 检查麦克风权限，确认设备未静音 |
| 应用崩溃 | 使用 `flutter run -v` 查看日志 |

---

## 关键文件说明

| 文件 | 作用 |
|------|------|
| `pubspec.yaml` | 项目依赖与配置 |
| `lib/main.dart` | 应用启动与路由 |
| `lib/services/livekit_service.dart` | LiveKit SDK 封装 |
| `android/AndroidManifest.xml` | Android 权限配置 |
| `ios/Runner/Info.plist` | iOS 权限配置 |
| `DEPLOYMENT.md` | 完整部署指南 |
| `SETUP_GUIDE.md` | 环境搭建指南 |

---

## 资源链接

| 资源 | 链接 |
|------|------|
| Flutter 官方文档 | https://flutter.dev/docs |
| LiveKit 官方文档 | https://docs.livekit.io |
| LiveKit SDK | https://pub.dev/packages/livekit_client |
| Android Studio | https://developer.android.com/studio |
| Xcode | https://developer.apple.com/xcode |

---

## 开发工作流

```
1. 创建分支：git checkout -b feature/my-feature
2. 在 lib/ 中编写功能
3. 运行应用并热重载：终端内按 r
4. 提交代码：git commit -m "feat: description"
5. 推送：git push origin feature/my-feature
6. 创建 Pull Request
```

---

## 关键权限

- **Camera**：视频采集
- **Microphone**：音频采集
- **Internet**：连接服务器
- **Network State**：检测网络状态

AndroidManifest.xml 与 Info.plist 中已完成配置。

---

## API 速查

```dart
// 加入房间
await liveKitService.connect(url, token, roomName);

// 麦克风开关
liveKitService.toggleMicrophone(enabled);

// 摄像头开关
liveKitService.toggleCamera(enabled);

// 离开房间
await liveKitService.disconnect();

// 获取参会者流
liveKitService.participantsStream
```

---

## UI 组件

| 组件 | 文件 | 用途 |
|------|------|------|
| Home Screen | home_screen.dart | 加入房间界面 |
| Call Screen | call_screen.dart | 视频通话界面 |
| Participant | participant_widget.dart | 参会者视频窗口 |
| Room Dialog | room_input_dialog.dart | 连接信息输入弹窗 |

---

## 部署检查清单

- [ ] 在 `pubspec.yaml` 中更新应用版本
- [ ] 在真实设备（Android & iOS）上测试
- [ ] 生成 Android 签名密钥
- [ ] 准备 iOS 开发者账号与证书
- [ ] 构建发布 APK/App Bundle（Android）
- [ ] 构建发布 IPA（iOS）
- [ ] 准备应用商店素材
- [ ] 提交审核
- [ ] 上线后监控崩溃与分析数据

---

## 性能优化提示

1. 尽量使用 `const` 构造函数
2. 在 `dispose()` 中释放资源
3. 优先使用 `StreamBuilder` 替代频繁 `setState`
4. 在弱网下降低视频分辨率
5. 缓存开销较大的计算
6. 使用 DevTools 监控内存

---

## 安全建议

1. 切勿硬编码 API Key 或令牌
2. 生产环境使用 HTTPS/WSS
3. 设置令牌过期时间
4. 验证所有用户输入
5. 在后端安全生成令牌
6. 不在设备本地存储敏感令牌
7. 登出时清理敏感信息

---

## 项目自定义修改

### Android 应用 ID
编辑 `android/app/build.gradle`：
```gradle
applicationId "com.yourcompany.yourapp"
```

### iOS Bundle ID
编辑 `ios/Runner.pbxproj`：
```
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.yourapp;
```

### 应用名称
编辑 `pubspec.yaml`：
```yaml
name: your_app_name
```

---

## 下一步

1. **快速上手**：参照本页“5 分钟快速启动”
2. **完整配置**：阅读 [SETUP_GUIDE.md](./SETUP_GUIDE.md)
3. **准备上线**：阅读 [DEPLOYMENT.md](./DEPLOYMENT.md)
4. **功能扩展**：参阅 [OPTIONAL_FEATURES.md](./OPTIONAL_FEATURES.md)

---

## 支持

- **问题排查**：参考本页“常见问题速解”
- **项目概览**：查看 [README.md](./README.md)
- **部署指南**：查看 [DEPLOYMENT.md](./DEPLOYMENT.md)
- **环境搭建**：查看 [SETUP_GUIDE.md](./SETUP_GUIDE.md)

---

**速查手册最后更新**：2024
