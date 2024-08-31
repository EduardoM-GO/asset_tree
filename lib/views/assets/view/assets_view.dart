import 'dart:async';

import 'package:asset_tree/controllers/asset_controller.dart';
import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/views/assets/widgets/assets_body_widget.dart';
import 'package:flutter/material.dart';

class AssetsView extends StatefulWidget {
  final String companyId;
  const AssetsView({super.key, required this.companyId});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  late final AssetController assetController;

  late final List<Asset> assets;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    assetController = AssetController();
    assets = [];
    isLoading = false;
    scheduleMicrotask(getAssets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AssetsBodyWidget(assets: assets),
    );
  }

  void getAssets() async {
    setState(() {
      isLoading = true;
    });

    final [resultAssets, resultLocations] = await Future.wait([
      assetController.getAssetsByCompany(companyId: widget.companyId),
      assetController.getLocationsByCompany(companyId: widget.companyId)
    ]);

    setState(() {
      isLoading = false;
    });

    if (!mounted) {
      return;
    }

    if (resultAssets.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultAssets.error),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (resultLocations.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultLocations.error),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    assets
      ..clear()
      ..addAll([...resultAssets.success, ...resultLocations.success]);
  }
}
