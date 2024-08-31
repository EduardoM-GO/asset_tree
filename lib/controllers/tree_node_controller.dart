import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/models/tree_node.dart';
import 'package:flutter/foundation.dart';

class TreeNodeController {
  Future<List<TreeNode>> getTreeRoots(List<Asset> assets) =>
      compute<List<Asset>, List<TreeNode>>(_assetsToTreeRoots, assets);

  List<TreeNode> _assetsToTreeRoots(List<Asset> assets) {
    List<TreeNode> treeRoots =
        assets.where((e) => e.isRoot).map((e) => TreeNode(asset: e)).toList();

    for (int i = 0; i < treeRoots.length; i++) {
      final children =
          _treeRootToTreeNodes(asset: treeRoots[i].asset, assest: assets);

      treeRoots[i] = treeRoots[i].copyWith(children: children);
    }
    return treeRoots;
  }

  List<TreeNode> _treeRootToTreeNodes(
      {required Asset asset, required List<Asset> assest}) {
    final List<TreeNode> treeNodes = [];

    final children = assest
        .where((e) => e.parentId == asset.id || e.locationId == asset.id)
        .toList();

    for (final child in children) {
      final childTreeNodes = _treeRootToTreeNodes(asset: child, assest: assest);

      treeNodes.add(TreeNode(asset: child, children: childTreeNodes));
    }

    return treeNodes;
  }
}
