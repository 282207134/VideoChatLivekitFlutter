import 'package:flutter/material.dart';

import '../utils/app_config.dart';

class RoomInputDialog extends StatefulWidget {
  final Function(String url, String token, String roomName) onJoinRoom;

  const RoomInputDialog({
    Key? key,
    required this.onJoinRoom,
  }) : super(key: key);

  @override
  State<RoomInputDialog> createState() => _RoomInputDialogState();
}

class _RoomInputDialogState extends State<RoomInputDialog> {
  late TextEditingController _urlController;
  late TextEditingController _tokenController;
  late TextEditingController _roomController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: AppConfig.liveKitUrl);
    _tokenController = TextEditingController();
    _roomController = TextEditingController();
  }

  Future<void> _submit() async {
    final url = _urlController.text.trim();
    final token = _tokenController.text.trim();
    final room = _roomController.text.trim();

    if (url.isEmpty || token.isEmpty || room.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onJoinRoom(url, token, room);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Join Room'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'LiveKit Server URL',
                hintText: 'ws://your-server.com',
                helperText: '默认：${AppConfig.liveKitUrl}',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.language),
              ),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'JWT Token',
                hintText: 'eyJhbGc...',
                helperText: '使用环境变量中的 API Key/Secret 生成房间令牌',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.security),
              ),
              obscureText: true,
              enabled: !_isLoading,
              maxLines: null,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(
                labelText: 'Room Name',
                hintText: 'my-room',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.meeting_room),
              ),
              enabled: !_isLoading,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : const Text('Join'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    _tokenController.dispose();
    _roomController.dispose();
    super.dispose();
  }
}
