import 'dart:async';
import 'dart:isolate';

import 'package:asset_tree/controllers/filter_asset.dart';
import 'package:asset_tree/controllers/tree_node_controller.dart';
import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/models/tree_node.dart';
import 'package:asset_tree/views/assets/widgets/assets_filter_widget.dart';
import 'package:asset_tree/views/assets/widgets/card_asset_widget.dart';
import 'package:asset_tree/widgets/infinite_list_view_widget.dart';
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
  late final List<CardAssetWidget> treeRootsWidgets;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    treeNodeController = TreeNodeController();
    treeRootsWidgets = [];
    isLoading = false;

    scheduleMicrotask(getTreeRoots);
  }

  StreamSubscription<List<TreeNode>>? subscription;

  @override
  void dispose() {
    searchController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(child: Text('Sem dados'));

    if (isLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else if (treeRootsWidgets.isNotEmpty) {
      child = InfiniteListViewWidget(pageSize: 3, children: treeRootsWidgets);
    }

    return Padding(
      padding: const EdgeInsets.all(.0),
      child: Column(
        children: [
          AssetsFilterWidget(
            isLoading: isLoading,
            onFilter: onFilter,
          ),
          const SizedBox(height: 16),
          Expanded(child: child),
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

    final widgets = await treeRootsToWidgets(result);
    setState(() {
      treeRootsWidgets
        ..clear()
        ..addAll(widgets);
      isLoading = false;
    });
  }

  Future<void> onFilter(FilterAsset filter) async {
    setState(() {
      isLoading = true;
    });

    final result = await treeNodeController.filterTreeNodes(filter);
    if (!mounted) {
      return;
    }
    final widgets = await treeRootsToWidgets(result);

    setState(() {
      treeRootsWidgets
        ..clear()
        ..addAll(widgets);
      isLoading = false;
    });
  }

  Future<List<CardAssetWidget>> treeRootsToWidgets(
      List<TreeNode> treeRoots) async {
    final result = await Isolate.run<List<CardAssetWidget>>(() => List.generate(
        treeRoots.length,
        (index) => CardAssetWidget(treeNode: treeRoots[index])));

    return result;
  }
}
