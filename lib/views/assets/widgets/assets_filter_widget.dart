import 'package:asset_tree/models/asset.dart';
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

  @override
  void initState() {
    super.initState();
    status = null;
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar Ativo ou Local',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => onFilter(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
             
            ],
          )
        ],
      );

  void onFilter() => widget.onFilter(search: search, status: status);
}
