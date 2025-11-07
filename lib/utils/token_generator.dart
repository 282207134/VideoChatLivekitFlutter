import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../config/livekit_config.dart';

/// Token 生成工具类
/// 注意：在生产环境中，Token 应该由后端服务器生成
/// 这里仅用于开发测试目的
class TokenGenerator {
  /// 生成访问令牌
  /// 
  /// [roomName] 房间名称
  /// [participantIdentity] 参与者身份标识（必须唯一）
  /// [participantName] 参与者显示名称（可选）
  /// [ttl] 令牌有效期（秒），默认 6 小时
  static String generateToken({
    required String roomName,
    required String participantIdentity,
    String? participantName,
    int ttl = 21600, // 6 小时
  }) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = now + ttl;

    // 创建 JWT header
    final header = {
      'alg': 'HS256',
      'typ': 'JWT',
    };

    // 创建 JWT payload
    final payload = {
      'iss': LiveKitConfig.apiKey,
      'exp': exp,
      'nbf': now - 1,
      'sub': participantIdentity,
      if (participantName != null) 'name': participantName,
      'video': {
        'room': roomName,
        'roomJoin': true,
      },
    };

    // Base64 URL 编码
    final encodedHeader = _base64UrlEncode(jsonEncode(header));
    final encodedPayload = _base64UrlEncode(jsonEncode(payload));

    // 创建签名
    final signature = _createSignature(
      '$encodedHeader.$encodedPayload',
      LiveKitConfig.apiSecret,
    );

    return '$encodedHeader.$encodedPayload.$signature';
  }

  /// Base64 URL 编码
  static String _base64UrlEncode(String input) {
    final bytes = utf8.encode(input);
    final base64 = base64Encode(bytes);
    return base64
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
  }

  /// 创建 HMAC-SHA256 签名
  static String _createSignature(String data, String secret) {
    final key = utf8.encode(secret);
    final message = utf8.encode(data);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(message);
    // 直接对字节进行 Base64 URL 编码
    final base64 = base64Encode(digest.bytes);
    return base64
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
  }
}

