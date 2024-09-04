import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/models/tree_node.dart';
import 'package:flutter/foundation.dart';

class TreeNodeController {
  final List<TreeNode> _treeRoots = [];

  Future<List<TreeNode>> getTreeRoots(List<Asset> assets) async {
    final result =
        await compute<List<Asset>, List<TreeNode>>(_assetsToTreeRoots, assets);

    _treeRoots
      ..clear()
      ..addAll(result);

    return _treeRoots.toList();
  }

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

  Stream<List<TreeNode>> filterTreeRoots(
      {required String search, required StatusAsset? status}) async* {
    if (search.isEmpty && status == null) {
      yield _treeRoots;
      return;
    }

    final List<TreeNode> treeNodes = [];

    for (final treeRoot in _treeRoots) {
      if (treeRoot.children.isEmpty) {
        continue;
      }
      final children = _filterTreeNodes(
          search: search, status: status, treeNodes: treeRoot.children);

      if (children.isNotEmpty) {
        treeNodes.add(treeRoot.copyWith(children: children));
      }
      if (_isFilterAsset(
          asset: treeRoot.asset, search: search, status: status)) {
        treeNodes.add(treeRoot.copyWith(children: []));
      }
      yield treeNodes;
    }
  }

  List<TreeNode> _filterTreeNodes(
      {required String search,
      required StatusAsset? status,
      required List<TreeNode> treeNodes}) {
    final List<TreeNode> resultTreeNodes = [];

    for (final treeNode in treeNodes) {
      final children = _filterTreeNodes(
          search: search, status: status, treeNodes: treeNode.children);

      if (children.isNotEmpty) {
        resultTreeNodes.add(treeNode.copyWith(children: children));
        continue;
      }

      if (_isFilterAsset(
          asset: treeNode.asset, search: search, status: status)) {
        resultTreeNodes.add(treeNode);
        continue;
      }
    }

    return resultTreeNodes;
  }

  bool _isFilterAsset(
      {required Asset asset,
      required String search,
      required StatusAsset? status}) {
    if (search.isNotEmpty &&
        !asset.name.toLowerCase().contains(search.toLowerCase())) {
      return false;
    }

    if (status != null && asset.status != status) {
      return false;
    }

    return true;
  }
}
