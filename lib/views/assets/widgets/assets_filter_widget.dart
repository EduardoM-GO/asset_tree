import 'dart:async';

import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/widgets/button_selection_widget.dart';
import 'package:flutter/material.dart';

typedef OnFilter = void Function(
    {required String search, required StatusAsset? status});

class AssetsFilterWidget extends StatefulWidget {
  final OnFilter onFilter;
  const AssetsFilterWidget({super.key, required this.onFilter});

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
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              hintText: 'Buscar Ativo ou Local',
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
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
      );

  void onFilter() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500),
        () => widget.onFilter(search: search, status: status));
  }
}
