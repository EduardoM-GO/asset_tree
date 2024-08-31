import 'dart:convert';

import 'package:asset_tree/models/company.dart';
import 'package:asset_tree/utils/result.dart';
import 'package:http/http.dart' as http;

class CompanyController {
  Future<Result<List<Company>>> getAllCompanies() async {
    try {
      final response =
          await http.get(Uri.parse('http://fake-api.tractian.com/companies'));
      if (response.statusCode != 200) {
        return const Result.error('Failed to fetch companies');
      }

      final List<dynamic> companiesJson = jsonDecode(response.body);
      final companies =
          companiesJson.map((e) => Company.fromMap(Map.from(e))).toList();

      return Result.success(companies);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
