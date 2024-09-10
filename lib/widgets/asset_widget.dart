import 'package:flutter/material.dart';

enum AssetPath {
  logo('assets/images/logo.png'),
  icon('assets/images/icon.png');

  final String caminho;
  const AssetPath(this.caminho);
}

class AssetWidget extends StatelessWidget {
  final AssetPath assetPath;
  final double? height;
  final double? width;
  const AssetWidget(
      {super.key, required this.assetPath, this.height, this.width});

  @override
  Widget build(BuildContext context) => Image.asset(
        assetPath.caminho,
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
}
