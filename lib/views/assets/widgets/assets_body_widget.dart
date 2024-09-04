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
    } else if (treeRoots.isNotEmpty) {
      child = ListView.builder(
        itemCount: treeRoots.length,
        itemBuilder: (context, index) => CardAssetWidget(
            key: Key(index.toString()), treeNode: treeRoots[index]),
      );
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

    setState(() {
      treeRoots
        ..clear()
        ..addAll(result);
      isLoading = false;
    });
  }

  Future<void> onFilter(
      {required String search, required StatusAsset? status}) async {
    setState(() {
      isLoading = true;
    });
    await subscription?.cancel();
    subscription = treeNodeController
        .filterTreeRoots(search: search, status: status)
        .listen((event) {
      if (!mounted) {
        return;
      }

      setState(() {
        treeRoots
          ..clear()
          ..addAll(event);
        isLoading = false;
      });
    });
  }
}
