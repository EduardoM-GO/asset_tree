import 'dart:async';

import 'package:asset_tree/controllers/tree_node_controller.dart';
import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/models/tree_node.dart';
import 'package:asset_tree/views/assets/widgets/assets_filter_widget.dart';
import 'package:asset_tree/views/assets/widgets/card_asset_widget.dart';
import 'package:flutter/material.dart';

class AssetsBodyWidget extends StatefulWidget {
  final List<Asset> assets;
  const AssetsBodyWidget({super.key, required this.assets});

  @override
  State<AssetsBodyWidget> createState() => _AssetsBodyWidgetState();
}

class _AssetsBodyWidgetState extends State<AssetsBodyWidget> {
  late final TextEditingController searchController;
  late final TreeNodeController treeNodeController;
  late final List<TreeNode> treeRoots;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    treeNodeController = TreeNodeController();
    treeRoots = [];
    isLoading = false;

    scheduleMicrotask(getTreeRoots);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AssetsFilterWidget(
            onFilter: ({required search, required status}) {},
          ),
          const SizedBox(height: 16),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: treeRoots.length,
                    itemBuilder: (context, index) {
                      final TreeNode treeNode = treeRoots[index];
                      return CardAssetWidget(treeNode: treeNode);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> getTreeRoots() async {
    setState(() {
      isLoading = true;
    });

    final result = await treeNodeController.getTreeRoots(widget.assets);

    if (!mounted) {
      return;
    }

    setState(() {
      treeRoots
        ..clear()
        ..addAll(result);
      isLoading = false;
    });
  }
}
