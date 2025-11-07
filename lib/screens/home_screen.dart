import 'package:flutter/material.dart';
import '../services/livekit_service.dart';
import '../widgets/room_input_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LiveKitService _liveKitService = LiveKitService();
  bool _isLoading = false;

  void _showRoomInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RoomInputDialog(
        onJoinRoom: _joinRoom,
      ),
    );
  }

  Future<void> _joinRoom(String url, String token, String roomName) async {
    if (url.isEmpty || token.isEmpty || roomName.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _liveKitService.connect(url, token, roomName);
      if (!mounted) return;

      Navigator.of(context).pushNamed('/call');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to join room: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveKit Video Call'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.video_call,
                  size: 60,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Video Calling',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Connect with others using LiveKit',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : () => _showRoomInputDialog(context),
                  icon: const Icon(Icons.phone),
                  label: _isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text('Join Room'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requirements:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('• LiveKit Server URL'),
                    const Text('• Valid JWT Token'),
                    const Text('• Room Name'),
                    const SizedBox(height: 12),
                    Text(
                      'Camera and microphone permissions are required.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _liveKitService.dispose();
    super.dispose();
  }
}
