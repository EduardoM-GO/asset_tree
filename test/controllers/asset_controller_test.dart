import 'package:asset_tree/controllers/asset_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String companyId;
  late AssetController assetController;

  setUp(() {
    companyId = '662fd0ee639069143a8fc387';
    assetController = AssetController();
  });

  test('asset controller - getAssetsByCompany', () async {
    final result =
        await assetController.getAssetsByCompany(companyId: companyId);

    expect(result.isSuccess, isTrue);
    expect(result.success, hasLength(9));
    expect(result.success[1].id, equals('656734821f4664001f296973'));
    expect(result.success[1].name, equals('Fan - External'));
    expect(result.success[1].gatewayId, equals('QHI640'));
    expect(result.success[1].locationId, isNull);
    expect(result.success[1].parentId, isNull);
    expect(result.success[1].sensorId, 'MTC052');
    expect(result.success[1].sensorType, 'energy');
    expect(result.success[1].status, 'operating');
  });

  test('asset controller - getLocationsByCompany', () async {
    final result =
        await assetController.getLocationsByCompany(companyId: companyId);

    expect(result.isSuccess, isTrue);
    expect(result.success, hasLength(4));
    expect(result.success.first.id, equals('656a07b3f2d4a1001e2144bf'));
    expect(result.success.first.name, equals('CHARCOAL STORAGE SECTOR'));
    expect(result.success.first.parentId, equals('65674204664c41001e91ecb4'));
  });
}
