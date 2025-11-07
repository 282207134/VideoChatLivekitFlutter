# LiveKit Flutter 视频通话 - 文档索引

本文件汇总了项目中所有文档的用途与内容，方便快速查阅。

## 📚 文档总览

### 核心文档

#### [README.md](./README.md) - 入门首选
**适合场景**：快速了解项目

内容包含：
- 项目功能概览
- 5 分钟快速上手
- 应用结构
- 使用说明
- 故障排查
- 常用资源链接

**如果你是初次接触本项目，请先阅读此文档。**

---

#### [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - 速查手册
**适合场景**：开发过程中的快速查阅

内容包含：
- 5 分钟启动指南
- 常用命令
- 项目结构速览
- 令牌生成示例
- 常见问题速解
- 关键文件说明
- API 速查

**当你在开发中需要快速找到答案时，首选此文档。**

---

#### [SETUP_GUIDE.md](./SETUP_GUIDE.md) - 环境搭建
**适合场景**：首次搭建开发环境

内容包含：
- 前置条件与系统要求
- 各操作系统上的 Flutter 安装
- IDE 配置（Android Studio、VS Code、IntelliJ）
- Android 模拟器配置
- iOS 模拟器配置
- LiveKit 账号创建
- 令牌生成流程
- 开发工作流
- 调试技巧

**如果你正在搭建开发环境，请按照本指南操作。**

---

#### [DEPLOYMENT.md](./DEPLOYMENT.md) - 完整部署指南 ⭐
**适合场景**：准备上架应用商店

内容包含：
- 软件与硬件前置条件
- Android 部署步骤
  - 配置
  - 调试/发布构建
  - 签名配置
  - 实机/模拟器安装
  - Google Play 发布
- iOS 部署步骤
  - 配置
  - 构建方式
  - 实机/模拟器运行
  - App Store 发布
- LiveKit 服务器搭建（云端与自建）
- JWT 令牌生成（Node.js 与 Python）
- 测试流程
- 故障排查
- 性能优化

**当你要将应用部署到生产环境时，请详细阅读此文档。**

---

### 参考文档

#### [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) - 架构说明
**适合场景**：了解项目组织结构

内容包含：
- 目录树详解
- 关键文件说明
- 开发流程
- 代码组织原则
- 命名规范
- 新功能扩展流程
- 测试结构
- 性能考虑
- 安全建议
- 调试技巧

**如果你想深入了解代码结构，请阅读此文档。**

---

#### [OPTIONAL_FEATURES.md](./OPTIONAL_FEATURES.md) - 可选增强功能
**适合场景**：扩展高级能力

内容包含：
- Firebase 集成（分析、崩溃）
- 分析数据配置与示例
- 崩溃监控配置
- 推送通知（FCM）
- 后端服务搭建（Node.js、Python）
- 安全最佳实践
- 性能优化策略
- 测试示例

**如果你想添加分析、崩溃上报或通知功能，请参考此文档。**

---

#### [CONTRIBUTING.md](./CONTRIBUTING.md) - 贡献指南
**适合场景**：向项目提交贡献

内容包含：
- 行为准则
- 开始贡献（Fork、克隆、初始化）
- 代码风格要求
- 文件组织模式
- 注释与文档规范
- 错误处理模式
- 测试要求
- 提交信息格式
- Pull Request 流程
- Issue 报告模板

**若你计划贡献代码或文档，请务必遵循本指南。**

---

### 配置文件

#### [pubspec.yaml](./pubspec.yaml)
**作用**：Flutter 项目清单

内容包含：
- 项目名称与描述
- 依赖项
- 开发工具配置
- 构建参数
- 资源路径

#### [analysis_options.yaml](./analysis_options.yaml)
**作用**：Dart 静态分析配置

内容包含：
- Lint 规则
- 代码质量设置

#### [.gitignore](./.gitignore)
**作用**：Git 忽略规则

内容包含：
- 需忽略的生成文件
- 构建输出
- IDE 相关文件
- 操作系统临时文件

---

## 📖 按角色阅读建议

### 新用户 / 测试人员
1. 入门： [README.md](./README.md)
2. 速查： [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
3. 排障： [DEPLOYMENT.md](./DEPLOYMENT.md#故障排查)

### 首次参与开发的工程师
1. 入门： [README.md](./README.md)
2. 环境： [SETUP_GUIDE.md](./SETUP_GUIDE.md)
3. 架构： [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)
4. 速查： [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)

### 持续开发的工程师
1. 常用参考： [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
2. 深度理解： [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)
3. 按需查看：其他专题文档

### 运维 / 部署人员
1. 开始： [DEPLOYMENT.md](./DEPLOYMENT.md)
2. 服务器配置： [DEPLOYMENT.md#livekit-服务器配置](./DEPLOYMENT.md#livekit-服务器配置)
3. 故障排查： [DEPLOYMENT.md#故障排查](./DEPLOYMENT.md#故障排查)

### 贡献者
1. 贡献流程： [CONTRIBUTING.md](./CONTRIBUTING.md)
2. 代码规范： [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)
3. 环境说明： [SETUP_GUIDE.md](./SETUP_GUIDE.md)

### 功能扩展
1. 参考： [OPTIONAL_FEATURES.md](./OPTIONAL_FEATURES.md)
2. 对应配置：请查看文件内的具体章节
3. 实现示例：文档内附带代码与步骤

---

## 📋 快速导航

### 按主题

#### 快速入门
- [README.md](./README.md) - 项目概览
- [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - 5 分钟上手
- [SETUP_GUIDE.md](./SETUP_GUIDE.md) - 完整环境搭建

#### 开发过程
- [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) - 代码组织
- [SETUP_GUIDE.md](./SETUP_GUIDE.md) - IDE 配置
- [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - 常用命令

#### 部署
- [DEPLOYMENT.md](./DEPLOYMENT.md) - 完整部署指南
- [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - 部署检查清单

#### Android 专题
- [DEPLOYMENT.md#android-部署](./DEPLOYMENT.md#android-部署)
- [SETUP_GUIDE.md#步骤-5-android-环境配置](./SETUP_GUIDE.md#步骤-5-android-环境配置)

#### iOS 专题
- [DEPLOYMENT.md#ios-部署](./DEPLOYMENT.md#ios-部署)
- [SETUP_GUIDE.md#步骤-6-ios-环境配置仅适用于-macos](./SETUP_GUIDE.md#步骤-6-ios-环境配置仅适用于-macos)

#### LiveKit 集成
- [DEPLOYMENT.md#livekit-服务器配置](./DEPLOYMENT.md#livekit-服务器配置)
- [QUICK_REFERENCE.md#令牌生成示例](./QUICK_REFERENCE.md#令牌生成示例)

#### 故障排查
- [DEPLOYMENT.md#故障排查](./DEPLOYMENT.md#故障排查)
- [QUICK_REFERENCE.md#常见问题速解](./QUICK_REFERENCE.md#常见问题速解)
- [README.md#故障排查](./README.md#-故障排查)

#### 功能与增强
- [OPTIONAL_FEATURES.md](./OPTIONAL_FEATURES.md) - Firebase、分析等
- [README.md#功能](./README.md#-功能)

#### 贡献指南
- [CONTRIBUTING.md](./CONTRIBUTING.md) - 贡献流程
- [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) - 代码规范

---

## 🎯 常见任务

### 任务：加入视频通话
- 参考： [README.md#使用说明](./README.md#-使用说明)
- 速查： [QUICK_REFERENCE.md#5-分钟快速启动](./QUICK_REFERENCE.md#5-分钟快速启动)

### 任务：发布到 Google Play
- 参考： [DEPLOYMENT.md#发布到-google-play-store](./DEPLOYMENT.md#发布到-google-play-store)

### 任务：发布到 App Store
- 参考： [DEPLOYMENT.md#发布到-app-store](./DEPLOYMENT.md#发布到-app-store)

### 任务：构建发布 APK
- 速查： [QUICK_REFERENCE.md#构建](./QUICK_REFERENCE.md#构建)
- 详解： [DEPLOYMENT.md#发布构建](./DEPLOYMENT.md#发布构建)

### 任务：构建发布 IPA
- 速查： [QUICK_REFERENCE.md#构建](./QUICK_REFERENCE.md#构建)
- 详解： [DEPLOYMENT.md#发布构建](./DEPLOYMENT.md#发布构建)

### 任务：修复构建错误
1. 尝试： [QUICK_REFERENCE.md#常见问题速解](./QUICK_REFERENCE.md#常见问题速解)  
2. 若仍未解决： [DEPLOYMENT.md#故障排查](./DEPLOYMENT.md#故障排查)

### 任务：集成 Firebase Analytics
- 参考： [OPTIONAL_FEATURES.md#firebase-集成](./OPTIONAL_FEATURES.md#firebase-集成)

### 任务：生成 JWT 令牌
- 速查： [QUICK_REFERENCE.md#令牌生成示例](./QUICK_REFERENCE.md#令牌生成示例)
- 详解： [DEPLOYMENT.md#生成-jwt-令牌](./DEPLOYMENT.md#生成-jwt-令牌)

### 任务：向项目贡献代码
- 请阅读： [CONTRIBUTING.md](./CONTRIBUTING.md)

### 任务：理解代码架构
- 请阅读： [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)

---

## 📱 按平台查看

### Android 专区
- 环境搭建： [SETUP_GUIDE.md#步骤-5-android-环境配置](./SETUP_GUIDE.md#步骤-5-android-环境配置)
- 部署流程： [DEPLOYMENT.md#android-部署](./DEPLOYMENT.md#android-部署)
- Manifest： [android/app/src/main/AndroidManifest.xml](./android/app/src/main/AndroidManifest.xml)
- 构建配置： [android/app/build.gradle](./android/app/build.gradle)

### iOS 专区
- 环境搭建： [SETUP_GUIDE.md#步骤-6-ios-环境配置仅适用于-macos](./SETUP_GUIDE.md#步骤-6-ios-环境配置仅适用于-macos)
- 部署流程： [DEPLOYMENT.md#ios-部署](./DEPLOYMENT.md#ios-部署)
- 配置文件： [ios/Runner/Info.plist](./ios/Runner/Info.plist)
- Podfile： [ios/Podfile](./ios/Podfile)

---

## 📚 外部资源

### 官方文档
- [Flutter Documentation](https://flutter.dev/docs)
- [LiveKit Documentation](https://docs.livekit.io)
- [Dart Language Guide](https://dart.dev/guides)

### 工具与平台
- [Android Studio](https://developer.android.com/studio)
- [Xcode](https://developer.apple.com/xcode)
- [Visual Studio Code](https://code.visualstudio.com)
- [Firebase Console](https://console.firebase.google.com)
- [LiveKit Cloud Console](https://cloud.livekit.io)

### 社区
- [Flutter Community](https://flutter.dev/community)
- [LiveKit GitHub](https://github.com/livekit)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

---

## 🔍 如何快速找到内容

### 按文件后缀
- `.dart` - 位于 `lib/` 的 Flutter 代码
- `.yaml` - 配置文件
- `.md` - 当前目录下的文档
- `.xml` - Android 配置
- `.plist` - iOS 配置
- `.gradle` - Android 构建脚本
- `.kt` - Kotlin 代码

### 按目录
- `lib/` - Dart/Flutter 源码
- `android/` - Android 平台代码
- `ios/` - iOS 平台代码
- `test/` - 单元与 Widget 测试
- `/`（根目录）- 配置与文档

### 按紧急程度
- **立即需要**： [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
- **操作指南**： [DEPLOYMENT.md](./DEPLOYMENT.md)、[SETUP_GUIDE.md](./SETUP_GUIDE.md)
- **深入阅读**： [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)
- **参考资料**： [OPTIONAL_FEATURES.md](./OPTIONAL_FEATURES.md)

---

## 💡 实用建议

1. **收藏**与你职责最相关的文档
2. **善用 Ctrl+F / Cmd+F** 在文档内搜索
3. **初次使用先读** README.md
4. **遇到问题先看** QUICK_REFERENCE.md
5. **发布之前复查** DEPLOYMENT.md
6. **贡献代码请遵循** CONTRIBUTING.md

---

## 📝 文档维护状态

| 文档 | 最后更新 | 涵盖主题 | 适用范围 |
|------|----------|----------|----------|
| README.md | 2024 | 概览、功能、使用 | 面向用户 |
| DEPLOYMENT.md | 2024 | 完整部署指南 | 生产环境 |
| SETUP_GUIDE.md | 2024 | 环境搭建 | 开发环境 |
| PROJECT_STRUCTURE.md | 2024 | 代码架构 | 源码结构 |
| OPTIONAL_FEATURES.md | 2024 | 高级功能 | 能力扩展 |
| QUICK_REFERENCE.md | 2024 | 速查内容 | 日常开发 |
| CONTRIBUTING.md | 2024 | 贡献规范 | 贡献者 |

---

## 🤝 获取帮助

若仍未找到所需信息：

1. **全局搜索**文档内容（Ctrl+F / Cmd+F）
2. **查看** [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) 的故障排查部分
3. **阅读** 相关文档的对应章节
4. **在 GitHub** 上提交 Issue 寻求帮助
5. **参考** 上文列出的外部资源

---

**文档索引最后更新**：2024
