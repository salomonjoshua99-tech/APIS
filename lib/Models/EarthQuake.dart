class Earthquake {
  const Earthquake({
    required this.place,
    required this.magnitude,
    required this.time,
    required this.url,
  });

  final String place;
  final double magnitude;
  final DateTime time;
  final String url;

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>? ?? {};
    final rawMagnitude = properties['mag'];
    final rawTime = properties['time'];

    return Earthquake(
      place: properties['place'] as String? ?? 'Unknown location',
      magnitude: rawMagnitude is num ? rawMagnitude.toDouble() : 0,
      time: rawTime is num
          ? DateTime.fromMillisecondsSinceEpoch(rawTime.toInt())
          : DateTime.fromMillisecondsSinceEpoch(0),
      url: properties['url'] as String? ?? '',
    );
  }
}
