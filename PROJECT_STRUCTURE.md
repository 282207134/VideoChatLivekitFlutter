# 项目结构概览

## 目录树

```
livekit-flutter-video-call/
├── android/                          # Android 平台代码
│   ├── app/
│   │   ├── build.gradle             # Android 应用构建配置
│   │   └── src/main/
│   │       ├── AndroidManifest.xml  # Android 应用清单
│   │       └── kotlin/
│   │           └── com/livekit/videocall/
│   │               └── MainActivity.kt
│   └── build.gradle                 # Android 根级构建配置
├── ios/                             # iOS 平台代码
│   ├── Runner/
│   │   ├── Info.plist              # iOS 应用配置
│   │   └── Assets.xcassets/        # iOS 图标与资源
│   ├── Podfile                      # CocoaPods 配置
│   └── Runner.xcworkspace/          # Xcode 工作区
├── lib/                             # Dart/Flutter 主代码
│   ├── main.dart                   # 应用入口
│   ├── screens/                    # UI 界面
│   │   ├── home_screen.dart        # 加入房间界面
│   │   └── call_screen.dart        # 通话界面
│   ├── services/                   # 业务逻辑服务
│   │   └── livekit_service.dart    # LiveKit SDK 封装
│   ├── widgets/                    # 可复用组件
│   │   ├── participant_widget.dart # 参会者视频组件
│   │   └── room_input_dialog.dart  # 房间信息输入弹窗
│   └── utils/                      # 工具函数
│       ├── app_config.dart         # 应用配置常量
│       └── permission_helper.dart  # 权限处理工具
├── assets/                          # 静态资源目录（含占位文件）
│   └── .gitkeep                     # 保持目录被跟踪
├── test/                           # 单元与 Widget 测试
│   ├── services/
│   │   └── livekit_service_test.dart
│   └── widgets/
│       └── participant_widget_test.dart
├── build/                          # 构建产物（已在 .gitignore 中）
├── .git/                           # Git 仓库数据
├── .env.example                    # LiveKit 环境变量示例文件
├── .gitignore                      # Git 忽略规则
├── pubspec.yaml                    # Flutter 依赖与配置
├── pubspec.lock                    # 锁定的依赖版本
├── README.md                       # 项目概览文档
├── DEPLOYMENT.md                   # 完整部署指南
├── SETUP_GUIDE.md                  # 开发环境搭建
├── OPTIONAL_FEATURES.md            # Firebase 与可选功能
├── PROJECT_STRUCTURE.md            # 本文档
├── analysis_options.yaml           # Dart 分析配置
└── LICENSE                         # MIT 许可证
```

## 文件说明

### 核心应用文件

#### `lib/main.dart`
- **用途**：应用入口文件
- **包含内容**：
  - `MyApp` 根组件
  - 应用主题配置
  - 路由定义
  - Material Design 3 设置
- **关键函数**：
  - `runApp()` 启动应用
  - 路由导航配置

#### `lib/screens/home_screen.dart`
- **用途**：加入视频房间的初始界面
- **包含内容**：
  - 房间加入表单
  - 权限请求处理
  - 跳转至通话界面
- **特性**：
  - 输入校验
  - 加载状态管理
  - 错误提示

#### `lib/screens/call_screen.dart`
- **用途**：视频通话界面
- **包含内容**：
  - 参会者视频网格
  - 通话控制按钮
  - 音视频开关
- **特性**：
  - 参会者实时刷新
  - 响应式布局
  - 结束通话处理

#### `lib/services/livekit_service.dart`
- **用途**：LiveKit SDK 封装与抽象
- **包含内容**：
  - 房间连接管理
  - 参会者跟踪
  - 媒体流处理
- **关键方法**：
  - `connect()` 加入房间
  - `disconnect()` 离开房间
  - `toggleMicrophone()` 麦克风静音切换
  - `toggleCamera()` 摄像头控制

#### `lib/widgets/participant_widget.dart`
- **用途**：单个参会者视频展示
- **包含内容**：
  - RTCVideoView 视频渲染
  - 参会者名称
  - 麦克风状态指示
- **特性**：
  - 实时视频
  - 状态更新

#### `lib/widgets/room_input_dialog.dart`
- **用途**：房间连接信息输入弹窗
- **包含内容**：
  - 服务器地址输入框
  - JWT 令牌输入框
  - 房间名称输入框
- **特性**：
  - 输入校验
  - 错误提示

#### `lib/utils/app_config.dart`
- **用途**：应用配置常量
- **包含内容**：
  - 应用版本信息
  - LiveKit 相关配置
  - UI 配置
  - 超时设置

#### `lib/utils/permission_helper.dart`
- **用途**：权限处理工具
- **包含内容**：
  - 摄像头权限请求
  - 麦克风权限请求
  - 权限状态检查
  - 跳转到系统设置

### 环境配置文件

- `.env.example`：提供 LiveKit Cloud 默认凭据，运行前可复制为 `.env` 并按需修改。
- `.env`：本地环境变量文件（在 `.gitignore` 中），通过 `flutter run --dart-define-from-file=.env` 注入。

### Android 平台文件

#### `android/AndroidManifest.xml`
- 声明应用权限
- 指定必需硬件
- 定义 Activity 与 Intent 过滤器
- 包含权限：INTERNET、CAMERA、RECORD_AUDIO 等

#### `android/app/build.gradle`
- Android 构建配置
- SDK 版本与依赖管理
- 签名配置
- Debug/Release 构建类型

#### `android/MainActivity.kt`
- Android 入口 Activity
- Flutter 集成配置
- （如需）平台通道实现

### iOS 平台文件

#### `ios/Runner/Info.plist`
- iOS 应用配置
- 权限描述文本
- 设备方向设置
- 功能声明

#### `ios/Podfile`
- CocoaPods 依赖管理
- iOS 构建设置
- Swift 与 iOS 版本要求

### 配置文件

#### `pubspec.yaml`
- Flutter 项目清单
- Dart 依赖：
  - `livekit_client` - LiveKit SDK
  - `permission_handler` - 权限管理
  - `cupertino_icons` - iOS 图标
  - `intl` - 国际化支持
- Flutter 设置：
  - 启用 Material Design
  - 资源配置

#### `pubspec.lock`
- 锁定依赖版本
- 保证构建可复现
- 由 `flutter pub get` 自动生成

#### `.gitignore`
- 排除不需提交的文件
- 忽略生成文件与构建输出
- 忽略 IDE 配置
- 忽略操作系统临时文件

### 文档文件

#### `README.md`
- 项目概览
- 功能列表
- 快速开始
- 使用说明
- 部署链接
- 故障排查
- 资源链接

#### `DEPLOYMENT.md`
- 前置条件
- Android 部署指南
- iOS 部署指南
- Google Play 上架流程
- Apple App Store 上架流程
- LiveKit 服务器配置
- 令牌生成指南
- 测试流程
- 故障排查

#### `SETUP_GUIDE.md`
- 开发环境搭建
- Flutter 安装
- IDE 配置
- Android 环境（模拟器/真机）
- iOS 环境（模拟器/真机）
- LiveKit 账号搭建
- 开发工作流
- 调试技巧

#### `OPTIONAL_FEATURES.md`
- Firebase 集成
- 数据分析配置
- 崩溃上报
- 推送通知
- 后端示例
- 安全最佳实践
- 性能优化

#### `PROJECT_STRUCTURE.md`
- 本文档
- 目录结构
- 文件说明
- 开发规范

### 构建输出（已忽略）

#### `build/`
- 编译后的应用包
- 生成代码
- 构建产物
- 各平台输出

#### `.dart_tool/`
- Dart 分析缓存
- 生成文件
- Flutter 工具数据

---

## 开发流程

### 1. 项目初始化
```
├── 克隆仓库
├── flutter pub get
├── cd android && ./gradlew clean && cd ..
├── cd ios && pod install && cd ..
└── flutter run
```

### 2. 功能开发
```
├── 创建功能分支
├── 在 lib/ 中修改代码
├── 热重载（终端按 r）
├── 进行测试
├── 提交修改
└── 推送至远端仓库
```

### 3. 发布构建
```
├── flutter build apk --release
├── flutter build appbundle --release（Android）
├── flutter build ios --release（iOS）
└── 发布到应用商店
```

---

## 代码组织原则

### 职责分离
- **screens/**：界面与交互
- **services/**：业务逻辑与 SDK 集成
- **widgets/**：可复用组件
- **utils/**：工具函数与配置

### 命名规范
- **文件**：`snake_case.dart`
- **类名**：`PascalCase`
- **方法/变量**：`camelCase`
- **常量**：私有使用 `camelCase`，公共使用 `UPPER_CASE`

### 引入顺序
1. Dart 标准库
2. Flutter 包
3. 第三方包（按字母顺序）
4. 相对路径（按字母顺序）

### 文件结构
- 顶部导入
- 类/函数定义
- 私有方法放底部
- 资源清理在 `dispose()` 中执行

---

## 新功能开发

### 新增页面
1. 创建 `lib/screens/new_screen.dart`
2. 继承 `StatefulWidget` 或 `StatelessWidget`
3. 实现 `build()` 方法
4. 在 `main.dart` 中注册路由
5. 更新导航逻辑

### 新增服务
1. 创建 `lib/services/new_service.dart`
2. （可选）实现单例模式
3. 补齐核心方法
4. 添加错误处理
5. 更新引用处

### 新增组件
1. 创建 `lib/widgets/new_widget.dart`
2. 设计必要参数
3. 实现 `build()` 方法
4. 说明用途与使用方式
5. 在需要的界面中引用

---

## 测试结构

### 单元测试
```
test/
├── services/
│   └── livekit_service_test.dart
├── utils/
│   └── permission_helper_test.dart
└── ...
```

### Widget 测试
```
test/
├── widgets/
│   ├── participant_widget_test.dart
│   └── room_input_dialog_test.dart
└── ...
```

### 集成测试
```
test_driver/
├── app.dart                    # 测试入口
└── app_test.dart               # 测试场景
```

---

## 性能考量

### 内存管理
- 在 `dispose()` 中释放资源
- 取消流订阅
- 清理大型数据结构
- 使用 `StreamBuilder` 提升重建效率

### 构建性能
- 尽量使用 `const` 构造函数
- 避免整体 Widget 重建
- 为列表项使用 `ValueKey`
- 在自定义 Provider 中实现 `shouldRebuild()`

### 网络优化
- 启用自适应流
- 做好重试逻辑
- 处理网络状态变化
- 必要时压缩媒体数据

---

## 安全考量

### 数据保护
- 不在本地存储敏感 Token
- 凭据应使用安全存储
- 退出时清理敏感数据
- 验证所有用户输入

### 接口安全
- 生产环境使用 HTTPS/WSS
- 设置令牌过期时间
- 校验 JWT 令牌
- 对接口设置速率限制

### 权限安全
- 仅请求必要权限
- 明确解释权限用途
- 妥善处理权限拒绝
- 尊重用户隐私

---

## 调试提示

### 常见调试位置

#### UI 相关
- `lib/screens/*.dart`：布局与结构
- `lib/widgets/*.dart`：组件渲染
- `pubspec.yaml`：依赖与资源

#### 逻辑相关
- `lib/services/*.dart`：业务逻辑
- `lib/utils/*.dart`：工具函数
- `main.dart`：路由与配置

#### 构建相关
- `pubspec.yaml`：依赖冲突
- `android/build.gradle`：Android 配置
- `ios/Podfile`：iOS 依赖

---

## 下一步建议

1. **阅读 README.md**：了解项目概况
2. **参考 SETUP_GUIDE.md**：搭建开发环境
3. **查阅 DEPLOYMENT.md**：掌握部署流程
4. **浏览 OPTIONAL_FEATURES.md**：扩展功能
5. **遵循规范开始开发**：按照上述约定进行实现

---

**最后更新**：2024
