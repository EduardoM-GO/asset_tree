import 'dart:convert';

import 'package:asset_tree/models/asset.dart';
import 'package:asset_tree/utils/result.dart';
import 'package:http/http.dart' as http;

class AssetController {
  Future<Result<List<Asset>>> getAssetsByCompany(
      {required String companyId}) async {
    try {
      final response = await http.get(Uri.parse(
          'http://fake-api.tractian.com/companies/$companyId/assets'));

      if (response.statusCode != 200) {
        return const Result.error('Failed to fetch assets');
      }

      final List<dynamic> assetsJson = jsonDecode(response.body);
      final assets = assetsJson
          .map((e) => Asset.fromMap(map: Map.from(e), isLocation: false))
          .toList();

      return Result.success(assets);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<List<Asset>>> getLocationsByCompany(
      {required String companyId}) async {
    try {
      final response = await http.get(Uri.parse(
          'http://fake-api.tractian.com/companies/$companyId/locations'));

      if (response.statusCode != 200) {
        return const Result.error('Failed to fetch locations');
      }

      final List<dynamic> locationsJson = jsonDecode(response.body);
      final locations = locationsJson
          .map((e) => Asset.fromMap(map: Map.from(e), isLocation: true))
          .toList();

      return Result.success(locations);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
