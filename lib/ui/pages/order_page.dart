import 'package:flutter/material.dart';

import 'package:api/models/earthquake.dart';
import 'package:api/services/api_service.dart';
import 'package:api/ui/atoms/app_message.dart';
import 'package:api/ui/atoms/loading_spinner.dart';
import 'package:api/ui/molecules/error_retry.dart';
import 'package:api/ui/organisms/earthquake_list.dart';
import 'package:api/ui/templates/page_template.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _api = ApiService();
  late Future<List<Earthquake>> _earthquakes;

  @override
  void initState() {
    super.initState();
    _earthquakes = _api.fetchEarthquakes();
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }

  void _retry() {
    setState(() {
      _earthquakes = _api.fetchEarthquakes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'The Order',
      child: FutureBuilder<List<Earthquake>>(
        future: _earthquakes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSpinner(label: 'Loading earthquakes...');
          }

          if (snapshot.hasError) {
            return ErrorRetry(message: snapshot.error.toString(), onRetry: _retry);
          }

          final earthquakes = snapshot.data ?? const <Earthquake>[];
          if (earthquakes.isEmpty) {
            return const AppMessage(
              title: 'No earthquakes found',
              message: 'The USGS feed returned an empty list.',
              icon: Icons.check_circle_outline,
            );
          }

          return EarthquakeList(earthquakes: earthquakes);
        },
      ),
    );
  }
}
