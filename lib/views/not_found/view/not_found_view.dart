import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  final RouteSettings settings;
  const NotFoundView({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Page not found: ${settings.name}'),
    );
  }
}
