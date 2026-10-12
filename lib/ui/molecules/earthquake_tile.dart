import 'package:flutter/material.dart';

import 'package:api/models/earthquake.dart';
import 'package:api/ui/atoms/magnitude_badge.dart';

class EarthquakeTile extends StatelessWidget {
  const EarthquakeTile({super.key, required this.earthquake});

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: MagnitudeBadge(magnitude: earthquake.magnitude),
      title: Text(earthquake.place),
      subtitle: Text(_formatDate(earthquake.time)),
    );
  }

  String _formatDate(DateTime dateTime) {
    final local = dateTime.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$month/$day/${local.year} $hour:$minute';
  }
}
