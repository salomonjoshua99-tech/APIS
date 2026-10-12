import 'dart:async';

import 'package:flutter/material.dart';

import 'package:api/models/iss_position.dart';
import 'package:api/services/api_service.dart';
import 'package:api/ui/atoms/loading_spinner.dart';
import 'package:api/ui/molecules/error_retry.dart';
import 'package:api/ui/organisms/iss_card.dart';
import 'package:api/ui/templates/page_template.dart';

class BeltPage extends StatefulWidget {
  const BeltPage({super.key});

  @override
  State<BeltPage> createState() => _BeltPageState();
}

class _BeltPageState extends State<BeltPage> {
  final _api = ApiService();
  late Stream<IssPosition> _issStream;

  @override
  void initState() {
    super.initState();
    _issStream = _api.issStream();
    
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }

  void _restart() {
    setState(() {
      _issStream = _api.issStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'The Belt',
      child: StreamBuilder<IssPosition>(
        stream: _issStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const LoadingSpinner(label: 'Finding the ISS...');
          }

          if (snapshot.hasData) {
            return Column(
              children: [
                if (snapshot.hasError)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      'Latest refresh failed: ${snapshot.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                Expanded(child: Center(child: IssCard(position: snapshot.data!))),
              ],
            );
          }

          if (snapshot.hasError) {
            return ErrorRetry(message: snapshot.error.toString(), onRetry: _restart);
          }

          return const LoadingSpinner(label: 'Finding the ISS...');
        },
      ),
    );
  }
}
