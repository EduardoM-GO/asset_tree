import 'package:flutter/material.dart';

class ButtonSelectionWidget extends StatefulWidget {
  final bool enabled;
  final String label;
  final IconData icon;
  final bool isSelected;
  final void Function(bool value) onChanged;
  const ButtonSelectionWidget({
    super.key,
    required this.enabled,
    required this.label,
    required this.icon,
    this.isSelected = false,
    required this.onChanged,
  });

  @override
  State<ButtonSelectionWidget> createState() => _ButtonSelectionWidgetState();
}

class _ButtonSelectionWidgetState extends State<ButtonSelectionWidget> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant ButtonSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      isSelected = widget.isSelected;
    }
  }

  late ColorScheme colorScheme;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colorScheme = Theme.of(context).colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.enabled
          ? () {
              setState(() {
                isSelected = !isSelected;
                widget.onChanged(isSelected);
              });
            }
          : null,
      label: Text(widget.label,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      icon: Icon(widget.icon),
      style: buttonStyle,
    );
  }

  ButtonStyle get buttonStyle {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        isSelected ? colorScheme.primary : Colors.white,
      ),
      foregroundColor: WidgetStatePropertyAll(
        isSelected ? Colors.white : Colors.grey,
      ),
    );
  }
}
