# LiveKit Flutter 视频通话

一个使用 LiveKit SDK 构建的简洁优雅的 Flutter 视频通话应用，展示如何搭建支持多名参与者的实时视频通信平台。

## 🎯 功能

- ✅ **实时视频通话** - 借助 LiveKit 优化的编解码获得清晰画质
- ✅ **音频通信** - 高品质音频并支持噪声抑制
- ✅ **多人房间** - 在同一房间连接多位用户
- ✅ **摄像头控制** - 通话过程中随时开/关摄像头
- ✅ **麦克风控制** - 支持静音与取消静音
- ✅ **权限处理** - 自动请求摄像头与麦克风权限
- ✅ **简洁界面** - 采用 Material Design 3 风格
- ✅ **Android 与 iOS 支持** - 覆盖两大主流移动平台
- ✅ **响应式布局** - 适配不同屏幕尺寸与方向

## 🚀 快速开始

### 前置条件

运行本应用前，请确认你已安装：

- **Flutter SDK**（>= 3.10.0）
- **Dart SDK**（>= 3.0.0）
- **Android SDK**（用于 Android 开发）
- **Xcode**（在 macOS 上进行 iOS 开发）
- **LiveKit Cloud 账户**或自建 LiveKit 服务器

### 安装步骤

1. **克隆仓库**
```bash
git clone <repository-url>
cd livekit-flutter-video-call
```

2. **获取依赖**
```bash
flutter pub get
```

3. **配置环境变量**
```bash
cp .env.example .env
# 然后根据需要更新 LIVEKIT_URL/LIVEKIT_API_KEY/LIVEKIT_API_SECRET
```
> 未提供自定义 `.env` 时，应用会使用内置的 LiveKit Cloud 默认值。

4. **运行应用**

Android 设备：
```bash
flutter run -d android --dart-define-from-file=.env
```

iOS 设备：
```bash
flutter run -d ios --dart-define-from-file=.env
```

任意已连接设备：
```bash
flutter run --dart-define-from-file=.env
```

## 📱 应用结构

```
lib/
├── main.dart                 # 应用入口与路由
├── screens/
│   ├── home_screen.dart      # 加入房间主界面
│   └── call_screen.dart      # 视频通话界面
├── services/
│   └── livekit_service.dart  # LiveKit SDK 封装服务
└── widgets/
    ├── participant_widget.dart    # 单个参会者视频方块
    └── room_input_dialog.dart     # 输入房间信息的弹窗

android/                      # Android 平台代码
├── app/
│   ├── build.gradle          # Android 构建配置
│   └── src/main/
│       ├── AndroidManifest.xml
│       └── kotlin/
│           └── MainActivity.kt
ios/                          # iOS 平台代码
└── Runner/
    └── Info.plist            # iOS 配置
```

## 💻 使用说明

### 1. 获取 LiveKit 凭据

#### 方案 A：LiveKit Cloud（推荐初学者使用）

1. 访问 [cloud.livekit.io](https://cloud.livekit.io)
2. 注册免费账号
3. 创建新项目
4. 复制 WebRTC URL（示例：`wss://your-project.livekit.cloud`）
5. 获取 API Key 与 Secret

> 当前仓库提供的 `.env.example` 已预置 `wss://dome-qtf8hjw3.livekit.cloud`、API Key 与 Secret，可直接用于测试。

#### 方案 B：自建 LiveKit 服务

```bash
# 使用 Docker
docker run -d \
  -p 7880:7880 \
  -p 7881:7881 \
  -p 7882:7882/udp \
  -p 7883:7883/udp \
  livekit/livekit-server
```

服务器地址示例：`ws://localhost:7880`

### 2. 生成 JWT 令牌

#### 使用 Node.js

```bash
npm install livekit
```

```javascript
const { AccessToken } = require("livekit-server-sdk");

const at = new AccessToken("api-key", "api-secret");
at.identity = "user-name";
at.addGrant({
  roomJoin: true,
  room: "room-name",
  canPublish: true,
  canSubscribe: true,
});

console.log(at.toJwt());
```

#### 使用 Python

```bash
pip install livekit
```

```python
from livekit import AccessToken, VideoGrants

token = AccessToken("api-key", "api-secret")
token.identity = "user-name"
token.add_grant(VideoGrants(
    room_join=True,
    room="room-name",
    can_publish=True,
    can_subscribe=True
))

print(token.toJwt())
```

### 3. 使用应用

1. **启动应用** 到你的设备
2. **点击 “Join Room”** 按钮
3. **输入以下信息**：
   - **LiveKit Server URL**：你的服务器地址（ws:// 或 wss://）
   - **JWT Token**：为该身份生成的令牌
   - **Room Name**：希望加入的房间名称
4. **授权权限**：系统提示时允许使用摄像头和麦克风
5. **开始通话**：你的画面将出现在屏幕上，同时可看到其他参会者
6. **控制选项**：
   - 🎤 麦克风静音/取消静音
   - 📹 摄像头开/关
   - 📞 结束通话返回主页

## 🔧 开发相关

### 项目依赖

```yaml
dependencies:
  livekit_client: ^0.5.0      # LiveKit SDK
  permission_handler: ^11.4.0 # 权限管理
  flutter: sdk
  cupertino_icons: ^1.0.2
  intl: ^0.19.0

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^2.0.0
```

### 构建应用

#### 调试构建

```bash
# 生成 Android APK
flutter build apk --debug

# 生成 iOS 模拟器构建
flutter build ios --debug --simulator
```
> 如需复用环境变量，可附加 `--dart-define-from-file=.env`。

#### 正式构建

```bash
# 生成 Android APK
flutter build apk --release

# 生成 Google Play 推荐的 App Bundle
flutter build appbundle --release

# 生成 iOS 正式包
flutter build ios --release
```
> 构建发布版本时同样可以追加 `--dart-define-from-file=.env` 覆盖运行时配置。

## 📋 部署指南

详细的部署步骤请参阅 [DEPLOYMENT.md](./DEPLOYMENT.md)，内容涵盖：

- ✅ Android 完整配置流程
- ✅ iOS 完整配置流程
- ✅ Google Play Store 上架说明
- ✅ Apple App Store 上架说明
- ✅ LiveKit 服务器配置
- ✅ JWT 令牌生成
- ✅ 常见问题排查
- ✅ 性能优化建议

## 🎨 界面组件

### 主页面（Home Screen）

- 欢迎语与应用图标
- “Join Room” 按钮
- 环境要求信息卡片
- 简洁的 Material Design 3 界面

### 通话页面（Call Screen）

- 参与者视频网格布局
- 展示参与者名称与音频状态
- 底部控制面板包含：
  - 🎤 麦克风切换
  - 📹 摄像头切换
  - 📞 结束通话按钮
- 自动监听并展示新加入的参会者

### 输入弹窗（Permission Dialog）

- 房间信息输入项：
  - LiveKit Server URL
  - JWT Token
  - Room Name
- 输入校验
- 连接时的加载状态

## 🔐 安全注意事项

1. **JWT 令牌**：切勿将令牌提交到版本控制
2. **HTTPS/WSS**：生产环境必须使用 `wss://`
3. **令牌过期时间**：合理设置令牌有效期
4. **API 密钥**：在后端安全存储 API Key
5. **默认凭据**：仓库中的示例凭据仅供本地测试，生产环境务必使用你自己的密钥
6. **权限**：仅请求必要的系统权限

## 🐛 故障排查

### 常见问题

**无法连接服务器？**
- 确认 URL 包含协议（ws:// 或 wss://）
- 检查防火墙设置
- 确保 LiveKit 服务器正在运行

**通话黑屏？**
- 检查是否授予摄像头权限
- 重启应用
- 在其他设备上尝试

**没有声音？**
- 检查麦克风权限
- 确保设备音量未静音
- 检查其他应用的麦克风设置

**应用启动即崩溃？**
- 运行 `flutter clean`
- 运行 `flutter pub get`
- 重新构建并运行

更多排查技巧请见 [DEPLOYMENT.md](./DEPLOYMENT.md#troubleshooting)

## 📚 资源

- **Flutter 官方文档**：https://flutter.dev/docs
- **LiveKit SDK 文档**：https://docs.livekit.io
- **LiveKit Flutter SDK**：https://pub.dev/packages/livekit_client
- **LiveKit GitHub**：https://github.com/livekit

## 🤝 参与贡献

欢迎贡献代码！流程如下：
1. Fork 本仓库
2. 创建新的功能分支
3. 完成修改
4. 提交 Pull Request

## 📄 许可证

本项目基于 MIT 许可证开源，详情参见 [LICENSE](LICENSE)。

## 💡 小贴士与最佳实践

### 面向用户

1. **光线**：充足的光线能显著提升画质
2. **带宽**：优先使用 WiFi 以获得最佳体验
3. **距离**：保持摄像头与面部 30-60cm 的距离
4. **背景**：选择整洁、专业的背景
5. **权限**：授予所需权限才能获得完整体验

### 面向开发者

1. **测试**：务必在真实设备上测试，别只依赖模拟器
2. **权限处理**：优雅地处理用户拒绝权限的情况
3. **错误处理**：为用户提供明确的错误反馈
4. **内存管理**：在 `dispose()` 中正确释放资源
5. **网络状态**：在通话过程中处理网络状态变化

## 🔄 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0.0 | 2024 | 初始发布，提供基础视频通话功能 |

## 📞 支持

如果遇到问题或有疑问：

1. 查看 [Troubleshooting](./DEPLOYMENT.md#troubleshooting) 部分
2. 阅读 [LiveKit 文档](https://docs.livekit.io)
3. 在 GitHub 提交 Issue
4. 联系 LiveKit 支持团队

## 🎓 学习资源

### 理解 WebRTC

- [WebRTC Explained](https://webrtc.org/getting-started)
- [Real-time Communication Concepts](https://www.html5rocks.com/en/tutorials/webrtc/basics/)

### Flutter 最佳实践

- [Flutter Architecture Patterns](https://flutter.dev/docs/development/architecture)
- [State Management Guide](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

### 集成 LiveKit

- [LiveKit Client SDK Guide](https://docs.livekit.io/guides/integrate-client-sdk/)
- [JWT Token Generation](https://docs.livekit.io/guides/access-control/)

---

**Happy coding! 🚀**

最后更新：2024
