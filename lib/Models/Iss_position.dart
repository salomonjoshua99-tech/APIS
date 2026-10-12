class IssPosition {
  const IssPosition({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.velocity,
    required this.timestamp,
  });

  final String name;
  final double latitude;
  final double longitude;
  final double altitude;
  final double velocity;
  final DateTime timestamp;

  factory IssPosition.fromJson(Map<String, dynamic> json) {
    return IssPosition(
      name: json['name'] as String? ?? 'ISS',
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      altitude: _toDouble(json['altitude']),
      velocity: _toDouble(json['velocity']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (_toDouble(json['timestamp']) * 1000).round(),
      ),
    );
  }

  static double _toDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }
}
