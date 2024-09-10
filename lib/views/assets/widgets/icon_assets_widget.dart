import 'package:flutter/material.dart';

class IconAssetsWidget extends StatelessWidget {
  final AssetImage image;
  final Key keyImagem;
  const IconAssetsWidget.location()
      : image = const AssetImage('assets/images/location.png'),
        keyImagem = const Key('IconAssetsWidget-location-Image'),
        super(key: const Key('IconAssetsWidget-location'));

  const IconAssetsWidget.component()
      : image = const AssetImage('assets/images/component.png'),
        keyImagem = const Key('IconAssetsWidget-component-Image'),
        super(key: const Key('IconAssetsWidget-component'));

  const IconAssetsWidget.asset()
      : image = const AssetImage('assets/images/asset.png'),
        keyImagem = const Key('IconAssetsWidget-asset-Image'),
        super(key: const Key('IconAssetsWidget-asset'));

  @override
  Widget build(BuildContext context) => Image(
        key: keyImagem,
        image: image,
        width: 22,
        height: 22,
        fit: BoxFit.cover,
      );
}
