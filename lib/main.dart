import 'package:flutter/material.dart';
import 'config/livekit_config.dart';
import 'pages/video_chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveKit Video Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _roomNameController = TextEditingController(
    text: 'my-room-${DateTime.now().millisecondsSinceEpoch}',
  );
  final TextEditingController _participantNameController = TextEditingController(
    text: 'user-${DateTime.now().millisecondsSinceEpoch % 10000}',
  );

  @override
  void dispose() {
    _roomNameController.dispose();
    _participantNameController.dispose();
    super.dispose();
  }

  void _startVideoChat() {
    final roomName = _roomNameController.text.trim();
    final participantName = _participantNameController.text.trim();

    if (roomName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入房间名称')),
      );
      return;
    }

    if (participantName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入参与者名称')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoChatPage(
          roomName: roomName,
          participantIdentity: participantName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('LiveKit 视频聊天'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '加入房间',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _roomNameController,
                decoration: const InputDecoration(
                  labelText: '房间名称',
                  hintText: '输入房间名称',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.meeting_room),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _participantNameController,
                decoration: const InputDecoration(
                  labelText: '参与者名称',
                  hintText: '输入您的名称',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _startVideoChat,
                  icon: const Icon(Icons.video_call),
                  label: const Text('开始视频聊天'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

