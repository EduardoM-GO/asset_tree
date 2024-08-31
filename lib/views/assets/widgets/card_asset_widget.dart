import 'package:asset_tree/models/tree_node.dart';
import 'package:asset_tree/views/assets/widgets/expansion_tile_tree_widget.dart';
import 'package:flutter/material.dart';

class CardAssetWidget extends StatelessWidget {
  final TreeNode treeNode;
  const CardAssetWidget({super.key, required this.treeNode});

  @override
  Widget build(BuildContext context) =>
      ExpansionTileTreeWidget(treeNode: treeNode, level: 0);
}
