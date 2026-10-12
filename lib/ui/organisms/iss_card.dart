import 'package:flutter/material.dart';

import 'package:api/models/iss_position.dart';
import 'package:api/ui/molecules/stat_row.dart';

class IssCard extends StatelessWidget {
  const IssCard({super.key, required this.position});

  final IssPosition position;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                position.name.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              StatRow(
                label: 'Latitude',
                value: position.latitude.toStringAsFixed(4),
              ),
              StatRow(
                label: 'Longitude',
                value: position.longitude.toStringAsFixed(4),
              ),
              StatRow(
                label: 'Altitude',
                value: '${position.altitude.toStringAsFixed(1)} km',
              ),
              StatRow(
                label: 'Velocity',
                value: '${position.velocity.toStringAsFixed(1)} km/h',
              ),
              StatRow(label: 'Updated', value: _formatTime(position.timestamp)),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    final second = local.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
