import 'package:flutter/material.dart';

import 'package:api/models/earthquake.dart';
import 'package:api/ui/molecules/earthquake_tile.dart';

class EarthquakeList extends StatelessWidget {
  const EarthquakeList({super.key, required this.earthquakes});

  final List<Earthquake> earthquakes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: earthquakes.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return EarthquakeTile(earthquake: earthquakes[index]);
      },
    );
  }
}
