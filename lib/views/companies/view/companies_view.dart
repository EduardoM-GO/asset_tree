import 'dart:async';

import 'package:asset_tree/controllers/company_controller.dart';
import 'package:asset_tree/models/company.dart';
import 'package:asset_tree/views/companies/widgets/card_company_widget.dart';
import 'package:asset_tree/widgets/asset_widget.dart';
import 'package:flutter/material.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  late final CompanyController companyController;
  late final List<Company> companies;
  late bool isLoading = false;

  @override
  void initState() {
    super.initState();
    companyController = CompanyController();
    companies = [];
    isLoading = true;
    scheduleMicrotask(getCompanies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AssetWidget(assetPath: AssetPath.logo),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              itemCount: companies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 32),
              itemBuilder: (_, index) =>
                  CardCompanyWidget(company: companies[index]),
            ),
    );
  }

  Future<void> getCompanies() async {
    setState(() {
      isLoading = true;
    });
    final result = await companyController.getAllCompanies();

    if (!mounted) {
      return;
    }

    if (result.isError) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.error),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      companies
        ..clear()
        ..addAll(result.success);
      isLoading = false;
    });
    return;
  }
}
