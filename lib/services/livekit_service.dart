import 'package:livekit_client/livekit_client.dart';

class LiveKitService {
  static final LiveKitService _instance = LiveKitService._internal();
  late Room _room;
  final List<Participant> _participants = [];

  factory LiveKitService() {
    return _instance;
  }

  LiveKitService._internal();

  Room? get room => _room;

  Stream<List<Participant>> get participantsStream {
    if (_room == null) {
      return Stream.value([]);
    }

    return _room!.participants.values.toList().asStream();
  }

  Future<void> connect(String url, String token, String roomName) async {
    try {
      final room = Room();

      final result = await room.connect(
        url,
        token,
        roomOptions: RoomOptions(
          adaptiveStream: true,
          autoSubscribe: true,
          dynacast: true,
        ),
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(enabled: true),
          camera: TrackOption(enabled: true),
        ),
      );

      _room = room;

      _room!.events.listen((event) {
        if (event is ParticipantJoinedEvent) {
          _participants.add(event.participant);
        } else if (event is ParticipantLeftEvent) {
          _participants.removeWhere(
            (p) => p.identity == event.participant.identity,
          );
        }
      });

      print('Connected to room: $roomName');
    } catch (e) {
      print('Error connecting to room: $e');
      rethrow;
    }
  }

  void toggleMicrophone(bool enable) {
    _room?.localParticipant?.setMicrophoneEnabled(enable);
  }

  void toggleCamera(bool enable) {
    _room?.localParticipant?.setCameraEnabled(enable);
  }

  Future<void> disconnect() async {
    await _room?.disconnect();
    _participants.clear();
  }

  void dispose() {
    disconnect();
  }
}
