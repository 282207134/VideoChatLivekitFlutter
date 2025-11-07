import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import '../services/livekit_service.dart';
import '../widgets/participant_widget.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late LiveKitService _liveKitService;
  bool _isMuted = false;
  bool _isCameraOff = false;

  @override
  void initState() {
    super.initState();
    _liveKitService = LiveKitService();
  }

  void _toggleMicrophone() {
    setState(() => _isMuted = !_isMuted);
    _liveKitService.toggleMicrophone(!_isMuted);
  }

  void _toggleCamera() {
    setState(() => _isCameraOff = !_isCameraOff);
    _liveKitService.toggleCamera(!_isCameraOff);
  }

  Future<void> _leaveRoom() async {
    await _liveKitService.disconnect();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _leaveRoom();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Call'),
          centerTitle: true,
          leading: const SizedBox.shrink(),
        ),
        body: StreamBuilder<RoomEvent>(
          stream: _liveKitService.room?.events,
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: _buildParticipantsList(),
                ),
                _buildControlPanel(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildParticipantsList() {
    return StreamBuilder<List<Participant>>(
      stream: _liveKitService.participantsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final participants = snapshot.data ?? [];

        if (participants.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                const Text('Waiting for other participants...'),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: participants.length,
          itemBuilder: (context, index) {
            return ParticipantWidget(participant: participants[index]);
          },
        );
      },
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(top: BorderSide(color: Colors.grey.shade700)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _toggleMicrophone,
            backgroundColor: _isMuted ? Colors.red : Colors.blue,
            mini: true,
            child: Icon(
              _isMuted ? Icons.mic_off : Icons.mic,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
            onPressed: _toggleCamera,
            backgroundColor: _isCameraOff ? Colors.red : Colors.blue,
            mini: true,
            child: Icon(
              _isCameraOff ? Icons.videocam_off : Icons.videocam,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
            onPressed: _leaveRoom,
            backgroundColor: Colors.red,
            mini: true,
            child: const Icon(Icons.call_end, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _liveKitService.dispose();
    super.dispose();
  }
}
