import 'dart:async';

import 'package:asset_tree/controllers/filter_asset.dart';
import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/widgets/button_selection_widget.dart';
import 'package:flutter/material.dart';

class AssetsFilterWidget extends StatefulWidget {
  final bool isLoading;
  final void Function(FilterAsset filter) onFilter;

  const AssetsFilterWidget({
    super.key,
    required this.isLoading,
    required this.onFilter,
  });

  @override
  State<AssetsFilterWidget> createState() => _AssetsFilterWidgetState();
}

class _AssetsFilterWidgetState extends State<AssetsFilterWidget> {
  late String search;
  late StatusAsset? status;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    search = '';
    status = null;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              enabled: !widget.isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                hintText: 'Buscar Ativo ou Local',
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 6, vertical: 16),
              ),
              onChanged: (value) {
                search = value;
                onFilter();
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ButtonSelectionWidget(
                  enabled: !widget.isLoading,
                  isSelected: status == StatusAsset.operating,
                  onChanged: (value) {
                    setState(() {
                      status = value ? StatusAsset.operating : null;
                    });
                    onFilter();
                  },
                  label: 'Sensor de Energia',
                  icon: Icons.bolt,
                ),
                const SizedBox(width: 16),
                ButtonSelectionWidget(
                  enabled: !widget.isLoading,
                  isSelected: status == StatusAsset.alert,
                  onChanged: (value) {
                    setState(() {
                      status = value ? StatusAsset.alert : null;
                    });
                    onFilter();
                  },
                  label: 'Crítico',
                  icon: Icons.error_outline,
                ),
              ],
            )
          ],
        ),
      );

  void onFilter() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500),
        () => widget.onFilter(FilterAsset(search: search, status: status)));
  }
}
