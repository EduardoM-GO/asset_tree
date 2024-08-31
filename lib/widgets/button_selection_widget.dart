import 'package:asset_tree/models/asset.dart';
import 'package:flutter/material.dart';

class ButtonSelectionWidget extends StatefulWidget {
  final void Function(bool value) onChanged;
  const ButtonSelectionWidget({super.key, required this.onChanged});

  @override
  State<ButtonSelectionWidget> createState() => _ButtonSelectionWidgetState();
}

class _ButtonSelectionWidgetState extends State<ButtonSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
