import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/models/tree_node.dart';

class FilterAsset {
  final String search;
  final StatusAsset? status;
  final List<TreeNode> treeRoots;

  const FilterAsset({
    required this.search,
    required this.status,
    this.treeRoots = const [],
  });

  FilterAsset copyWith({
    String? search,
    StatusAsset? status,
    List<TreeNode>? treeRoots,
  }) {
    return FilterAsset(
      search: search ?? this.search,
      status: status ?? this.status,
      treeRoots: treeRoots ?? this.treeRoots,
    );
  }
}
