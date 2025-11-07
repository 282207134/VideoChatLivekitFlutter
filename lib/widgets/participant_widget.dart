import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class ParticipantWidget extends StatefulWidget {
  final Participant participant;

  const ParticipantWidget({
    Key? key,
    required this.participant,
  }) : super(key: key);

  @override
  State<ParticipantWidget> createState() => _ParticipantWidgetState();
}

class _ParticipantWidgetState extends State<ParticipantWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.participant.videoTrackSubscriptions.values
          .isNotEmpty
          ? widget.participant.videoTrackSubscriptions.values.first.videoStream
          : Stream.value(false),
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Stack(
            children: [
              if (widget.participant.videoTracks.isNotEmpty)
                RTCVideoView(
                  widget.participant.videoTracks.values.first.track as VideoTrack,
                  key: ValueKey(widget.participant.sid),
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                )
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.videocam_off,
                        size: 48,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Camera Off',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.participant.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: StreamBuilder<TrackSubscriptionState>(
                  stream: widget.participant.audioTrackSubscriptions.values
                      .isNotEmpty
                      ? widget.participant.audioTrackSubscriptions.values.first
                          .subscriptionStateStream
                      : Stream.value(TrackSubscriptionState.unsubscribed),
                  builder: (context, snapshot) {
                    final isMuted = !widget.participant.audioTracks.isNotEmpty;
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isMuted ? Colors.red : Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isMuted ? Icons.mic_off : Icons.mic,
                        color: Colors.white,
                        size: 16,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
