import 'package:asset_tree/models/asset.dart';

class TreeNode {
  final Asset asset;
  final List<TreeNode> children;

  TreeNode({required this.asset, this.children = const []});

  TreeNode copyWith({Asset? asset, List<TreeNode>? children}) {
    return TreeNode(
      asset: asset ?? this.asset,
      children: children ?? this.children,
    );
  }
}
