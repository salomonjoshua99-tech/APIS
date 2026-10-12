import 'package:flutter/material.dart';

class MagnitudeBadge extends StatelessWidget {
  const MagnitudeBadge({super.key, required this.magnitude});

  final double magnitude;

  @override
  Widget build(BuildContext context) {
    final color = switch (magnitude) {
      >= 5 => Colors.red.shade700,
      >= 4 => Colors.deepOrange.shade700,
      >= 3 => Colors.amber.shade800,
      _ => Colors.green.shade700,
    };

    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        magnitude.toStringAsFixed(1),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
