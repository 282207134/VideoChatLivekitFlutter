import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  /// Request camera and microphone permissions
  static Future<bool> requestMediaPermissions() async {
    try {
      final cameraStatus = await Permission.camera.request();
      final micStatus = await Permission.microphone.request();

      final hasCameraPermission = cameraStatus.isGranted ||
          cameraStatus.isDenied && await _shouldRequestAgain(cameraStatus);
      final hasMicPermission = micStatus.isGranted ||
          micStatus.isDenied && await _shouldRequestAgain(micStatus);

      return hasCameraPermission && hasMicPermission;
    } catch (e) {
      print('Error requesting permissions: $e');
      return false;
    }
  }

  /// Check if camera permission is granted
  static Future<bool> hasCameraPermission() async {
    return (await Permission.camera.status).isGranted;
  }

  /// Check if microphone permission is granted
  static Future<bool> hasMicrophonePermission() async {
    return (await Permission.microphone.status).isGranted;
  }

  /// Open app settings for permission configuration
  static Future<bool> openAppSettings() async {
    return openAppSettings();
  }

  /// Helper method to check if permission should be requested again
  static Future<bool> _shouldRequestAgain(PermissionStatus status) async {
    if (status.isDenied) {
      return true;
    } else if (status.isDeniedForever) {
      return false;
    }
    return false;
  }

  /// Get human-readable permission status
  static String getPermissionStatusDescription(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Permission granted';
      case PermissionStatus.denied:
        return 'Permission denied';
      case PermissionStatus.restricted:
        return 'Permission restricted';
      case PermissionStatus.limited:
        return 'Permission limited';
      case PermissionStatus.permanentlyDenied:
        return 'Permission permanently denied';
    }
  }
}
