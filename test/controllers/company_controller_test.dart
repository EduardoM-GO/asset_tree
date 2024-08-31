import 'package:asset_tree/controllers/company_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CompanyController companyController;

  setUp(() {
    companyController = CompanyController();
  });

  test('company controller - getAllCompanies', () async {
    final result = await companyController.getAllCompanies();
    expect(result.isSuccess, isTrue);
    expect(result.success, hasLength(3));
    expect(result.success.first.id, equals('662fd0ee639069143a8fc387'));
    expect(result.success.first.name, equals('Jaguar'));
    expect(result.success[1].id, equals('662fd0fab3fd5656edb39af5'));
    expect(result.success[1].name, equals('Tobias'));
    expect(result.success.last.id, equals('662fd100f990557384756e58'));
    expect(result.success.last.name, equals('Apex'));
  });
}
