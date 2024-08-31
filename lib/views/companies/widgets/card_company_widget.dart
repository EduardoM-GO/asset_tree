import 'package:asset_tree/models/company.dart';
import 'package:asset_tree/widgets/asset_widget.dart';
import 'package:flutter/material.dart';

class CardCompanyWidget extends StatelessWidget {
  final Company company;
  const CardCompanyWidget({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: () =>
            Navigator.of(context).pushNamed('/assets', arguments: company.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Row(
            children: [
              const AssetWidget(
                assetPath: AssetPath.icon,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 16),
              Text(company.name,
                  style: TextStyle(
                      color: theme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
