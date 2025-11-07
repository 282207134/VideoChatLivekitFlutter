# LiveKit Flutter 视频通话 - 可选功能指南

本指南介绍可为应用新增的扩展能力与增强特性。

## 目录

1. [Firebase 集成](#firebase-集成)
2. [数据分析](#数据分析)
3. [崩溃上报](#崩溃上报)
4. [推送通知](#推送通知)
5. [后端服务](#后端服务)
6. [高级功能](#高级功能)
7. [安全最佳实践](#安全最佳实践)
8. [性能优化](#性能优化)
9. [测试](#测试)
10. [下一步](#下一步)

---

## Firebase 集成

Firebase 提供分析、崩溃上报与远程配置等工具。

### 1. 创建 Firebase 项目

1. 访问 [Firebase Console](https://console.firebase.google.com)
2. 创建新项目
3. 添加 Android 应用：
   - 包名：`com.livekit.videocall`
   - 下载 `google-services.json`
   - 放置于 `android/app/`
4. 添加 iOS 应用：
   - Bundle ID：`com.livekit.videocall`
   - 下载 `GoogleService-Info.plist`
   - 放置于 `ios/Runner/`

### 2. 添加 Firebase 依赖

更新 `pubspec.yaml`：

```yaml
dependencies:
  firebase_core: ^2.13.0
  firebase_analytics: ^10.4.0
  firebase_crashlytics: ^3.3.0
```

### 3. 初始化 Firebase

创建 `lib/firebase_options.dart`：

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}
```

---

## 数据分析

用于追踪用户行为与应用使用情况。

### 1. 基础事件上报

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // 房间加入事件
  static Future<void> logRoomJoined(String roomName) async {
    await _analytics.logEvent(
      name: 'room_joined',
      parameters: {
        'room_name': roomName,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // 通话时长
  static Future<void> logCallDuration(Duration duration) async {
    await _analytics.logEvent(
      name: 'call_ended',
      parameters: {
        'duration_seconds': duration.inSeconds,
      },
    );
  }

  // 按钮点击
  static Future<void> logButtonClick(String buttonName) async {
    await _analytics.logEvent(
      name: 'button_clicked',
      parameters: {
        'button_name': buttonName,
      },
    );
  }
}
```

### 2. 自定义用户属性

```dart
// 设置用户 ID
await FirebaseAnalytics.instance.setUserId(id: 'user_123');

// 设置用户属性
await FirebaseAnalytics.instance.setUserProperty(
  name: 'device_type',
  value: 'mobile',
);

await FirebaseAnalytics.instance.setUserProperty(
  name: 'app_version',
  value: '1.0.0',
);
```

### 3. 在控制台查看数据

- 打开 Firebase Console
- 进入 Analytics > Events
- 查看实时事件
- 分析用户画像
- 观察用户路径

---

## 崩溃上报

自动收集并上报应用崩溃信息。

### 1. 配置 Crashlytics

更新 `pubspec.yaml`：

```yaml
dependencies:
  firebase_crashlytics: ^3.3.0
```

### 2. 初始化 Crashlytics

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  // 捕获 Flutter 异常
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  // 捕获异步异常
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  runApp(const MyApp());
}
```

### 3. 记录异常

```dart
// 捕获并记录异常
try {
  await _liveKitService.connect(url, token, roomName);
} catch (e, stackTrace) {
  FirebaseCrashlytics.instance.recordError(
    e,
    stackTrace,
    reason: 'Failed to connect to LiveKit',
  );
  rethrow;
}
```

### 4. 自定义关键字段

```dart
// 为崩溃记录添加上下文
FirebaseCrashlytics.instance.setCustomKey('room_name', roomName);
FirebaseCrashlytics.instance.setCustomKey('user_id', userId);
FirebaseCrashlytics.instance.setCustomKey('device_model', deviceModel);
```

### 5. 在控制台查看崩溃

- 打开 Firebase Console
- 进入 Crashlytics
- 查看最新崩溃
- 检查堆栈信息
- 分析问题趋势

---

## 推送通知

向用户推送实时通知。

### 1. 配置 Firebase Cloud Messaging (FCM)

```bash
# 在 pubspec.yaml 中添加
dependencies:
  firebase_messaging: ^14.6.0
```

### 2. 请求权限

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> requestNotificationPermission() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not yet granted permission');
  }
}
```

### 3. 处理通知

```dart
// 前台消息
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Received message: ${message.notification?.title}');
  // TODO: 显示通知
});

// 后台消息
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}
```

### 4. 获取 FCM Token

```dart
// 获取设备令牌
final token = await FirebaseMessaging.instance.getToken();
print('FCM Token: $token');

// 将令牌发送到后端
// 后端可利用该令牌发送通知
```

---

## 后端服务

构建后端用于令牌生成与房间管理。

### 1. Node.js 示例

```javascript
// server.js
const express = require('express');
const { AccessToken, RoomServiceClient } = require('livekit-server-sdk');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const apiKey = process.env.LIVEKIT_API_KEY;
const apiSecret = process.env.LIVEKIT_API_SECRET;
const liveKitUrl = process.env.LIVEKIT_URL;

// 令牌生成接口
app.post('/api/token', (req, res) => {
  try {
    const { identity, roomName, metadata } = req.body;

    if (!identity || !roomName) {
      return res.status(400).json({
        error: 'identity and roomName required',
      });
    }

    const token = new AccessToken(apiKey, apiSecret);
    token.identity = identity;
    token.name = identity;
    token.metadata = metadata || '';

    token.addGrant({
      roomJoin: true,
      room: roomName,
      canPublish: true,
      canPublishData: true,
      canSubscribe: true,
    });

    return res.json({
      token: token.toJwt(),
      url: liveKitUrl,
    });
  } catch (error) {
    return res.status(500).json({
      error: error.message,
    });
  }
});

// 房间信息接口
app.get('/api/rooms/:roomName', async (req, res) => {
  try {
    const { roomName } = req.params;
    const svc = new RoomServiceClient(liveKitUrl, apiKey, apiSecret);
    
    const rooms = await svc.listRooms([roomName]);
    
    if (rooms.length === 0) {
      return res.status(404).json({
        error: 'Room not found',
      });
    }

    return res.json(rooms[0]);
  } catch (error) {
    return res.status(500).json({
      error: error.message,
    });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

### 2. Python 示例

```python
# server.py
from flask import Flask, request, jsonify
from flask_cors import CORS
from livekit import AccessToken, VideoGrants
import os

app = Flask(__name__)
CORS(app)

API_KEY = os.getenv('LIVEKIT_API_KEY')
API_SECRET = os.getenv('LIVEKIT_API_SECRET')
LIVEKIT_URL = os.getenv('LIVEKIT_URL')

@app.route('/api/token', methods=['POST'])
def generate_token():
    try:
        data = request.get_json()
        identity = data.get('identity')
        room_name = data.get('roomName')
        metadata = data.get('metadata', '')

        if not identity or not room_name:
            return jsonify({'error': 'identity and roomName required'}), 400

        token = AccessToken(API_KEY, API_SECRET)
        token.identity = identity
        token.name = identity
        token.metadata = metadata

        token.add_grant(VideoGrants(
            room_join=True,
            room=room_name,
            can_publish=True,
            can_subscribe=True
        ))

        return jsonify({
            'token': token.toJwt(),
            'url': LIVEKIT_URL,
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=3000)
```

### 3. Flutter 集成后端

```dart
class LiveKitService {
  final String backendUrl;

  LiveKitService({this.backendUrl = 'http://localhost:3000'});

  Future<void> joinRoomWithBackend(
    String identity,
    String roomName,
  ) async {
    try {
      // 从后端获取令牌
      final response = await http.post(
        Uri.parse('$backendUrl/api/token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'identity': identity,
          'roomName': roomName,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get token');
      }

      final data = jsonDecode(response.body);
      final url = data['url'];
      final token = data['token'];

      // 连接 LiveKit
      await connect(url, token, roomName);
    } catch (e) {
      print('Error joining room: $e');
      rethrow;
    }
  }
}
```

---

## 高级功能

### 1. 录制

```dart
// 如在 LiveKit 中启用录制，进入后台即可查看
// LiveKit 控制台 > Rooms > Recording
```

### 2. 转写

```dart
// 在 LiveKit 配置中启用
// 云控制台设置 > Recording & Transcription
```

### 3. 房间管理

```dart
// 获取活跃房间
final rooms = await roomService.listRooms();

// 删除房间
await roomService.deleteRoom('room-name');

// 获取指定房间
final info = await roomService.listRooms(['room-name']);
```

### 4. Webhooks

```javascript
// 接收房间事件
app.post('/webhook/livekit', (req, res) => {
  const event = req.body;
  
  console.log('Event:', event.event);
  console.log('Room:', event.room?.name);
  
  // 事件类型示例：
  // - participant_joined
  // - participant_left
  // - room_started
  // - room_finished
  
  res.sendStatus(200);
});
```

---

## 安全最佳实践

1. **切勿在客户端硬编码凭据**
2. **使用后端统一生成令牌**
3. **为令牌接口设置速率限制**
4. **在连接前验证 JWT 令牌有效性**
5. **生产环境务必使用 HTTPS/WSS**
6. **在后端正确配置 CORS**
7. **监控令牌过期时间并及时刷新**
8. **记录安全事件以备审计**

---

## 性能优化

### 1. 内存管理

```dart
@override
void dispose() {
  _room?.disconnect();
  _participants.clear();
  super.dispose();
}
```

### 2. 电量优化

```dart
// 在省电模式下降低视频分辨率
if (Platform.isAndroid) {
  final batteryManager = BatteryManager();
  if (await batteryManager.isBatterySaverOn) {
    // TODO: 使用较低分辨率
  }
}
```

### 3. 网络优化

```dart
// 启用自适应码率
RoomOptions(
  adaptiveStream: true,
  dynacast: true,
)
```

---

## 测试

### 1. 单元测试

```dart
test('LiveKit service initialization', () async {
  final service = LiveKitService();
  expect(service.room, isNull);
});
```

### 2. 集成测试

```dart
testWidgets('Join room flow', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  await tester.tap(find.byIcon(Icons.phone));
  await tester.pump();
  
  expect(find.byType(AlertDialog), findsOneWidget);
});
```

---

## 下一步

1. 按需选择并实现上述功能
2. 持续监控分析与崩溃数据
3. 根据真实使用情况优化体验
4. 收集用户反馈
5. 规划后续功能

---

**最后更新**：2024
