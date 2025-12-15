import 'package:flutter_test/flutter_test.dart';
import 'package:bug_away/Features/inventory/data/models/materail_model_dto.dart';

void main() {
  group('MaterailModelDto', () {
    // Test data
    const testId = 'material-001';
    const testName = 'Pesticide Spray';
    const testQuantity = 50;
    const testUnit = 'liters';

    final testMaterialData = {
      'id': testId,
      'name': testName,
      'quantity': testQuantity,
      'unit': testUnit,
    };

    test('should create MaterailModelDto with correct properties', () {
      // Arrange & Act
      final material = MaterailModelDto(
        id: testId,
        name: testName,
        quantity: testQuantity,
        unit: testUnit,
      );

      // Assert
      expect(material.id, equals(testId));
      expect(material.name, equals(testName));
      expect(material.quantity, equals(testQuantity));
      expect(material.unit, equals(testUnit));
    });

    test('toFirestore() should return correct Map representation', () {
      // Arrange
      final material = MaterailModelDto(
        id: testId,
        name: testName,
        quantity: testQuantity,
        unit: testUnit,
      );

      // Act
      final result = material.toFirestore();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], equals(testId));
      expect(result['name'], equals(testName));
      expect(result['quantity'], equals(testQuantity));
      expect(result['unit'], equals(testUnit));
    });

    test('fromFireStore() should create MaterailModelDto from Map', () {
      // Act
      final material = MaterailModelDto.fromFireStore(testMaterialData);

      // Assert
      expect(material, isA<MaterailModelDto>());
      expect(material.id, equals(testId));
      expect(material.name, equals(testName));
      expect(material.quantity, equals(testQuantity));
      expect(material.unit, equals(testUnit));
    });

    test('fromFireStore() should handle zero quantity', () {
      // Arrange
      final dataWithZeroQuantity = {
        'id': testId,
        'name': testName,
        'quantity': 0,
        'unit': testUnit,
      };

      // Act
      final material = MaterailModelDto.fromFireStore(dataWithZeroQuantity);

      // Assert
      expect(material, isA<MaterailModelDto>());
      expect(material.quantity, equals(0));
    });

    test('toFirestore() and fromFireStore() should be symmetric', () {
      // Arrange
      final originalMaterial = MaterailModelDto(
        id: testId,
        name: testName,
        quantity: testQuantity,
        unit: testUnit,
      );

      // Act
      final map = originalMaterial.toFirestore();
      final recreatedMaterial = MaterailModelDto.fromFireStore(map);

      // Assert
      expect(recreatedMaterial.id, equals(originalMaterial.id));
      expect(recreatedMaterial.name, equals(originalMaterial.name));
      expect(recreatedMaterial.quantity, equals(originalMaterial.quantity));
      expect(recreatedMaterial.unit, equals(originalMaterial.unit));
    });

    test('collectionName should be "materail"', () {
      // Assert
      expect(MaterailModelDto.collectionName, equals('materail'));
    });
  });
}
