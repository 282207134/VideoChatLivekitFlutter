# 为 LiveKit Flutter 视频通话项目做出贡献

感谢你对 LiveKit Flutter 视频通话项目的关注！本文档提供贡献的指南与流程说明。

## 行为准则

- 保持尊重与包容
- 避免任何形式的骚扰或歧视
- 欢迎多元观点
- 聚焦于问题与代码，而非个人

## 入门流程

### 1. Fork 并克隆仓库

```bash
# 在 GitHub 上 Fork，然后克隆你的 Fork
git clone https://github.com/your-username/livekit-flutter-video-call.git
cd livekit-flutter-video-call

# 添加上游仓库
git remote add upstream https://github.com/original-repo/livekit-flutter-video-call.git
```

### 2. 创建功能分支

```bash
# 同步主分支
git fetch upstream
git checkout main
git merge upstream/main

# 创建功能分支
git checkout -b feature/your-feature-name
```

### 3. 搭建开发环境

参照 [SETUP_GUIDE.md](./SETUP_GUIDE.md) 了解详细步骤。

```bash
flutter pub get
flutter analyze
```

## 开发规范

### 代码风格

#### Dart/Flutter 风格约定

```dart
// 1. 文件名使用蛇形命名：snake_case.dart
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// 2. 类名使用 PascalCase
class _MyWidgetState extends State<MyWidget> {
  // 3. 变量 / 方法使用 camelCase
  String myVariable = '';
  
  void myMethod() {
    // 4. 常量：优先使用小写 camelCase
    const myConstant = 'value';
  }
}

// 5. 能使用 const 构造函数时请务必使用
const SizedBox(height: 16)

// 6. 多行列表、参数等使用尾随逗号
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Item 1'),
      Text('Item 2'),
    ],
  );
}
```

### 文件组织结构

```dart
// 1. 导入顺序（按组划分）
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

// 2. Widget 定义
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// 3. State 定义
class _MyWidgetState extends State<MyWidget> {
  String _myVar = '';
  
  @override
  void initState() {
    super.initState();
    // 初始化逻辑
  }
  
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
  
  void _myHelperMethod() {}
  
  @override
  void dispose() {
    // 资源清理
    super.dispose();
  }
}
```

### 注释规范

合理使用注释：

```dart
// ✓ 说明“为什么”如此设计
// 使用 ListView 替代 Column，避免滚动性能问题
final list = ListView(children: items);

// ✗ 避免描述显而易见的“做了什么”
// 创建一个 ListView 组件
final list = ListView(children: items);

// ✓ 为公共 API 编写文档注释
/// 使用指定凭据连接 LiveKit 房间。
///
/// 抛出 [ConnectionException] 以指示连接失败。
Future<void> connect(String url, String token) async {
  // 实现细节
}

// ✗ 不必要的注释
// 将 name 设置为 'John'
name = 'John';
```

### 错误处理

```dart
// ✓ 明确区分不同错误
try {
  await _service.connect(url, token);
} on ConnectionException catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('连接失败：${e.message}')),
  );
} catch (e) {
  FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
  rethrow;
}

// ✗ 不建议的泛型处理
try {
  await _service.connect(url, token);
} catch (e) {
  print('Error: $e');
}
```

### 测试要求

为新功能编写测试：

```dart
void main() {
  group('LiveKitService', () {
    late LiveKitService service;

    setUp(() {
      service = LiveKitService();
    });

    test('初始化不应抛出异常', () {
      expect(service, isNotNull);
    });

    test('可成功连接房间', () async {
      const url = 'wss://test.livekit.cloud';
      const token = 'test-token';
      const room = 'test-room';

      await service.connect(url, token, room);

      expect(service.room, isNotNull);
    });
  });
}
```

## 提交规范

### 提交信息格式

遵循 Conventional Commits：

```
type(scope): description

body (可选)

footer (可选)
```

### 提交类型

- **feat**：新增功能
- **fix**：缺陷修复
- **docs**：文档更新
- **style**：格式调整
- **refactor**：重构
- **perf**：性能优化
- **test**：测试相关
- **chore**：构建、依赖或杂项

### 示例

```bash
# 新功能
git commit -m "feat(video): add camera toggle button"

# Bug 修复
git commit -m "fix(connection): handle network timeout properly"

# 文档更新
git commit -m "docs(deployment): add iOS deployment steps"

# 多行提交
git commit -m "feat(ui): improve participant grid layout

- Adjust spacing between tiles
- Add participant name display
- Fix orientation handling"
```

## Pull Request 流程

### 提交前检查

1. **确保代码符合风格规范**
   ```bash
   dart format .
   flutter analyze
   ```

2. **运行测试**
   ```bash
   flutter test
   ```

3. **更新文档**
   - 必要时更新 README.md
   - 复杂逻辑添加注释
   - 如有需要同步更新 CHANGELOG

4. **实际设备测试**
   - Android 真机或模拟器
   - iOS 模拟器（如可行）
   - 不同 Flutter 版本（如适用）

### PR 模板

```markdown
## Description
简要描述改动

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] All tests passing

## Screenshots (if applicable)
如有 UI 变化请附截图

## Checklist
- [ ] Code follows style guidelines
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No breaking changes introduced
```

### 代码评审期望

- 及时响应评审意见
- 在同一分支上完成修改
- 完成后请求再次评审
- 拥抱反馈并积极讨论

## Issue 提交

### Bug 报告

请包含以下信息：

```
## Description
问题描述

## Steps to Reproduce
1. 步骤 1
2. 步骤 2
3. 步骤 3

## Expected Behavior
期望行为

## Actual Behavior
实际行为

## Environment
- Flutter version: X.X.X
- Device/OS: Android 12 / iOS 15
- App version: 1.0.0

## Logs
相关错误日志
```

### 功能需求

请包含以下内容：

```
## Description
清晰描述希望新增的功能

## Use Case
说明该功能的使用场景与价值

## Proposed Solution
建议的实现思路

## Alternatives
可选方案或备选思路

## Additional Context
补充背景信息
```

## 文档维护

### 文档更新原则

- 保持 README.md 与最新状态一致
- 构建流程变化需更新 DEPLOYMENT.md
- 环境配置变化更新 SETUP_GUIDE.md
- 新功能补充示例或说明

### 代码注释模板

```dart
/// 简要说明类或方法的作用
///
/// 如有必要可以补充详细说明。
/// 可包含多行内容。
///
/// 示例：
/// ```dart
/// final token = await service.generateToken();
/// ```
///
/// 参数：
///   - param1: 参数说明
///
/// 返回值：
/// 返回内容描述
///
/// 可能抛出：
///   - [SomeException]: 触发条件说明
class MyClass {
}
```

## 评审流程

1. 提交 Pull Request
2. 自动化检查（Lint、测试）
3. 社区成员进行代码评审
4. 根据反馈进行修改
5. 审核通过后合并

## 贡献者认可

我们将：
- 在 CONTRIBUTORS.md 中感谢贡献者
- 在发布说明中提及贡献
- 在项目文档中对贡献者表示认可

## 有问题？

- 查看现有 Issue 与 PR
- 阅读仓库中的文档
- 提交讨论性 Issue
- 加入 LiveKit 社区

## 许可证

提交代码即表示同意按 MIT License 授权发布贡献内容。

---

感谢你的贡献！🎉

**贡献指南最后更新**：2024
