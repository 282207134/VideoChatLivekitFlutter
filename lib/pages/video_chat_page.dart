import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import '../config/livekit_config.dart';
import '../utils/token_generator.dart';

class VideoChatPage extends StatefulWidget {
  final String roomName;
  final String participantIdentity;

  const VideoChatPage({
    super.key,
    required this.roomName,
    required this.participantIdentity,
  });

  @override
  State<VideoChatPage> createState() => _VideoChatPageState();
}

class _VideoChatPageState extends State<VideoChatPage> {
  Room? _room;
  bool _isConnecting = false;
  bool _isConnected = false;
  bool _isCameraEnabled = false;
  bool _isMicrophoneEnabled = false;
  String? _errorMessage;
  List<RemoteParticipant> _remoteParticipants = [];

  @override
  void initState() {
    super.initState();
    _connectToRoom();
  }

  @override
  void dispose() {
    _disconnect();
    super.dispose();
  }

  Future<void> _connectToRoom() async {
    if (_isConnecting || _isConnected) return;

    setState(() {
      _isConnecting = true;
      _errorMessage = null;
    });

    try {
      // 生成 Token
      final token = TokenGenerator.generateToken(
        roomName: widget.roomName,
        participantIdentity: widget.participantIdentity,
        participantName: widget.participantIdentity,
      );

      // 创建房间并连接
      final room = Room(
        roomOptions: const RoomOptions(
          adaptiveStream: true,
          dynacast: true,
        ),
      );
      await room.connect(
        LiveKitConfig.url,
        token,
      );

      // 设置事件监听
      room.addListener(() {
        if (mounted) {
          setState(() {
            _remoteParticipants = room.remoteParticipants.values.toList();
          });
        }
      });

      // 监听参与者加入/离开事件
      room.addListener(() {
        if (mounted) {
          setState(() {
            _remoteParticipants = room.remoteParticipants.values.toList();
          });
        }
      });

      // 启用摄像头和麦克风
      try {
        await room.localParticipant?.setCameraEnabled(true);
        setState(() {
          _isCameraEnabled = true;
        });
      } catch (e) {
        debugPrint('无法启用摄像头: $e');
      }

      try {
        await room.localParticipant?.setMicrophoneEnabled(true);
        setState(() {
          _isMicrophoneEnabled = true;
        });
      } catch (e) {
        debugPrint('无法启用麦克风: $e');
      }

      setState(() {
        _room = room;
        _isConnected = true;
        _isConnecting = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '连接失败: $e';
        _isConnecting = false;
      });
    }
  }

  Future<void> _disconnect() async {
    if (_room != null) {
      await _room!.disconnect();
      _room = null;
    }
    setState(() {
      _isConnected = false;
      _isCameraEnabled = false;
      _isMicrophoneEnabled = false;
      _remoteParticipants = [];
    });
  }

  Future<void> _toggleCamera() async {
    if (_room == null || _room!.localParticipant == null) return;
    try {
      final enabled = !_isCameraEnabled;
      await _room!.localParticipant!.setCameraEnabled(enabled);
      setState(() {
        _isCameraEnabled = enabled;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('切换摄像头失败: $e')),
        );
      }
    }
  }

  Future<void> _toggleMicrophone() async {
    if (_room == null || _room!.localParticipant == null) return;
    try {
      final enabled = !_isMicrophoneEnabled;
      await _room!.localParticipant!.setMicrophoneEnabled(enabled);
      setState(() {
        _isMicrophoneEnabled = enabled;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('切换麦克风失败: $e')),
        );
      }
    }
  }

  Widget _buildVideoTrack(VideoTrack track) {
    return VideoTrackRenderer(
      track,
    );
  }

  Widget _buildLocalVideo() {
    if (_room == null || _room!.localParticipant == null || !_isCameraEnabled) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.person, size: 80, color: Colors.white54),
        ),
      );
    }

    final videoTrack = _room!.localParticipant!.videoTrackPublications
        .firstOrNull?.track as VideoTrack?;

    if (videoTrack == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _buildVideoTrack(videoTrack);
  }

  Widget _buildRemoteVideo(RemoteParticipant participant) {
    // 获取第一个视频轨道发布
    final videoPublication = participant.videoTrackPublications.firstOrNull;

    if (videoPublication == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 80, color: Colors.white54),
              const SizedBox(height: 8),
              Text(
                participant.identity,
                style: const TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      );
    }

    // 订阅视频轨道
    final videoTrack = videoPublication.track as VideoTrack?;

    if (videoTrack == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 80, color: Colors.white54),
              const SizedBox(height: 8),
              Text(
                participant.identity,
                style: const TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      );
    }

    return _buildVideoTrack(videoTrack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('房间: ${widget.roomName}'),
        actions: [
          if (_isConnected)
            IconButton(
              icon: const Icon(Icons.call_end),
              onPressed: () {
                _disconnect();
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: _isConnecting
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('正在连接...'),
                ],
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _connectToRoom,
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : _isConnected
                  ? Stack(
                      children: [
                        // 远程参与者视频（网格布局）
                        _remoteParticipants.isEmpty
                            ? Container(
                                color: Colors.black,
                                child: const Center(
                                  child: Text(
                                    '等待其他参与者加入...',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.all(8),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: _remoteParticipants.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _buildRemoteVideo(
                                        _remoteParticipants[index]),
                                  );
                                },
                              ),
                        // 本地视频（小窗口）
                        Positioned(
                          bottom: 100,
                          right: 16,
                          child: Container(
                            width: 120,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: _buildLocalVideo(),
                            ),
                          ),
                        ),
                        // 控制按钮
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.black87,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isCameraEnabled
                                        ? Icons.videocam
                                        : Icons.videocam_off,
                                    color: _isCameraEnabled
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                  onPressed: _toggleCamera,
                                  iconSize: 32,
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isMicrophoneEnabled
                                        ? Icons.mic
                                        : Icons.mic_off,
                                    color: _isMicrophoneEnabled
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                  onPressed: _toggleMicrophone,
                                  iconSize: 32,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.call_end,
                                      color: Colors.red),
                                  onPressed: () {
                                    _disconnect();
                                    Navigator.of(context).pop();
                                  },
                                  iconSize: 32,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
    );
  }
}
