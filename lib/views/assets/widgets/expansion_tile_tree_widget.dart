import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/models/tree_node.dart';
import 'package:asset_tree/views/assets/widgets/icon_assets_widget.dart';
import 'package:flutter/material.dart';

class ExpansionTileTreeWidget extends StatefulWidget {
  final TreeNode treeNode;
  final int level;

  const ExpansionTileTreeWidget(
      {super.key, required this.treeNode, required this.level});

  @override
  State<ExpansionTileTreeWidget> createState() =>
      _ExpansionTileTreeWidgetState();
}

class _ExpansionTileTreeWidgetState extends State<ExpansionTileTreeWidget> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    final statusIcon = switch (widget.treeNode.asset.status) {
      StatusAsset.operating => const Icon(
          Icons.bolt_rounded,
          color: Colors.green,
          size: 18,
        ),
      StatusAsset.alert => const Icon(
          Icons.circle,
          color: Colors.red,
          size: 10,
        ),
      _ => null
    };
    final isChildren = widget.treeNode.children.isNotEmpty;

    if (!isChildren) {
      return Padding(
        padding: EdgeInsets.only(left: 18.0 * widget.level),
        child: ListTile(
          title: Row(
            children: [
              SizedBox(width: widget.level > 0 ? 8 : 0),
              switch (widget.treeNode.asset.isLocation) {
                true => const IconAssetsWidget.location(),
                false when widget.treeNode.asset.isComponent =>
                  const IconAssetsWidget.component(),
                _ => const IconAssetsWidget.asset()
              },
              const SizedBox(width: 4),
              Text(
                widget.treeNode.asset.name.toUpperCase(),
                style: const TextStyle(fontSize: 14, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              if (statusIcon != null) ...[
                const SizedBox(width: 4),
                statusIcon,
              ]
            ],
          ),
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
        ),
      );
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 18.0 * widget.level),
      title: Row(
        children: [
          if (isChildren) ...[
            RepaintBoundary(
              child: AnimatedRotation(
                  turns: isExpanded ? 0 : 0.50,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                    size: 20,
                  )),
            ),
            const SizedBox(width: 4),
          ],
          switch (widget.treeNode.asset.isLocation) {
            true => const IconAssetsWidget.location(),
            false when widget.treeNode.asset.isComponent =>
              const IconAssetsWidget.component(),
            _ => const IconAssetsWidget.asset()
          },
          const SizedBox(width: 4),
          Text(
            widget.treeNode.asset.name.toUpperCase(),
            style: const TextStyle(fontSize: 14, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          if (statusIcon != null) ...[
            const SizedBox(width: 4),
            statusIcon,
          ]
        ],
      ),
      onExpansionChanged: (value) => setState(() {
        isExpanded = value;
      }),
      showTrailingIcon: false,
      dense: true,
      initiallyExpanded: true,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      childrenPadding: EdgeInsets.zero,
      children: List.generate(
        widget.treeNode.children.length,
        (index) => ExpansionTileTreeWidget(
          treeNode: widget.treeNode.children[index],
          level: widget.level + 1,
        ),
      ),
    );
  }
}
