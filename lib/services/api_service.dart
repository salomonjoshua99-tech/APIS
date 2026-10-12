import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:api/models/earthquake.dart';
import 'package:api/models/iss_position.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const _earthquakeUrl =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson';
  static const _issUrl = 'https://api.wheretheiss.at/v1/satellites/25544';
  static const _timeout = Duration(seconds: 10);

  final http.Client _client;

  Future<Map<String, dynamic>> _getJson(String url) async {
    final response = await _client.get(Uri.parse(url)).timeout(_timeout);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException('Request failed with status ${response.statusCode}.');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response format.');
    }

    return decoded;
  }

  Future<List<Earthquake>> fetchEarthquakes() async {
    final json = await _getJson(_earthquakeUrl);
    final features = json['features'];

    if (features is! List) {
      throw const ApiException('Earthquake feed did not include a feature list.');
    }

    return features
        .whereType<Map<String, dynamic>>()
        .map(Earthquake.fromJson)
        .toList();
  }

  Future<IssPosition> fetchIss() async {
    final json = await _getJson(_issUrl);
    return IssPosition.fromJson(json);
  }

  Stream<IssPosition> issStream() {
    late final StreamController<IssPosition> controller;
    Timer? timer;

    Future<void> load() async {
      try {
        controller.add(await fetchIss());
      } catch (error, stackTrace) {
        controller.addError(error, stackTrace);
      }
    }

    controller = StreamController<IssPosition>(
      onListen: () {
        load();
        timer = Timer.periodic(const Duration(seconds: 5), (_) => load());
      },
      onCancel: () {
        timer?.cancel();
      },
    );

    return controller.stream;
  }

  void close() {
    _client.close();
  }
}

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
