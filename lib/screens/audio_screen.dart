import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isLooping = true;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  double volume = 1.0;

  @override
  void initState() {
    super.initState();

    audioPlayer.setReleaseMode(ReleaseMode.loop);

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() => totalDuration = duration);
    });

    audioPlayer.onPositionChanged.listen((position) {
      setState(() => currentPosition = position);
    });

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        currentPosition = Duration.zero;
        isPlaying = false;
      });
    });
  }

  Future<void> _toggleAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(AssetSource("audio/AC_2_OST_Ezio's_Track.mp3"));
    }
    setState(() => isPlaying = !isPlaying);
  }

  Future<void> _rewind() async {
    final newPosition = currentPosition - const Duration(seconds: 10);
    await audioPlayer.seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  Future<void> _forward() async {
    final newPosition = currentPosition + const Duration(seconds: 10);
    await audioPlayer.seek(newPosition < totalDuration ? newPosition : totalDuration);
  }

  Future<void> _toggleLooping() async {
    setState(() => isLooping = !isLooping);
    await audioPlayer.setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.stop);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10141E),
      appBar: AppBar(
        title: const Text('Now Playing', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF10141E),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isLooping ? Icons.loop : Icons.repeat_one, color: Colors.white),
            onPressed: _toggleLooping,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/cover.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ezio's Family",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Jesper Kyd • Assassin's Creed II",
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Slider(
              value: currentPosition.inSeconds.toDouble(),
              min: 0,
              max: totalDuration.inSeconds.toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await audioPlayer.seek(newPosition);
              },
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Colors.white30,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(currentPosition), style: const TextStyle(color: Colors.white70)),
                  Text(_formatDuration(totalDuration), style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 25),

            /// Controls Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10, size: 36, color: Colors.white),
                  onPressed: _rewind,
                ),
                const SizedBox(width: 20),

                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    size: 80,
                    color: Colors.deepPurpleAccent,
                  ),
                  onPressed: _toggleAudio,
                ),

                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.forward_10, size: 36, color: Colors.white),
                  onPressed: _forward,
                ),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                const Icon(Icons.volume_up, color: Colors.white),
                Expanded(
                  child: Slider(
                    value: volume,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    onChanged: (value) async {
                      await audioPlayer.setVolume(value);
                      setState(() => volume = value);
                    },
                    activeColor: Colors.deepPurpleAccent,
                    inactiveColor: Colors.white30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
