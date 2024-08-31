import 'package:asset_tree/controllers/tree_node_controller.dart';
import 'package:asset_tree/models/asset.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TreeNodeController treeNodeController;

  setUp(() {
    treeNodeController = TreeNodeController();
  });

  test('tree node controller - getTreeRoots', () async {
    final result = await treeNodeController.getTreeRoots([
      const Asset(
        id: '1',
        name: 'Root',
        parentId: null,
        isLocation: false,
      ),
      const Asset(
        id: '2',
        name: 'Child 1',
        parentId: '1',
        isLocation: false,
      ),
      const Asset(
        id: '3',
        name: 'Child 2',
        parentId: '1',
        isLocation: false,
      ),
      const Asset(
        id: '4',
        name: 'Child 3',
        parentId: '2',
        isLocation: false,
      ),
      const Asset(
        id: '5',
        name: 'Child 4',
        parentId: '2',
        isLocation: false,
      ),
      const Asset(
        id: '6',
        name: 'Child 5',
        parentId: '3',
        isLocation: false,
      ),
      const Asset(
        id: '7',
        name: 'Child 6',
        parentId: '3',
        isLocation: false,
      ),
    ]);

    expect(result, hasLength(1));
    expect(result[0].asset.id, equals('1'));
    expect(result[0].asset.name, equals('Root'));
    expect(result[0].children, hasLength(2));
    expect(result[0].children[0].asset.id, equals('2'));
    expect(result[0].children[0].asset.name, equals('Child 1'));
    expect(result[0].children[0].children, hasLength(2));
    expect(result[0].children[0].children[0].asset.id, equals('4'));
    expect(result[0].children[0].children[0].asset.name, equals('Child 3'));
    expect(result[0].children[0].children[1].asset.id, equals('5'));
    expect(result[0].children[0].children[1].asset.name, equals('Child 4'));
    expect(result[0].children[1].asset.id, equals('3'));
    expect(result[0].children[1].asset.name, equals('Child 2'));
    expect(result[0].children[1].children, hasLength(2));
    expect(result[0].children[1].children[0].asset.id, equals('6'));
    expect(result[0].children[1].children[0].asset.name, equals('Child 5'));
    expect(result[0].children[1].children[1].asset.id, equals('7'));
    expect(result[0].children[1].children[1].asset.name, equals('Child 6'));
  });
}
