import 'package:flutter_test/flutter_test.dart';
import 'package:bug_away/Features/register/data/models/user_model_dto.dart';

void main() {
  group('UserAndAdminModelDto', () {
    // Test data
    const testId = 'test-user-123';
    const testImage = 'https://example.com/image.png';
    const testType = 'admin';
    const testUserName = 'John Doe';
    const testPhone = '+1234567890';
    const testEmail = 'john@example.com';
    final testFcmToken = ['token1', 'token2'];

    final testUserData = {
      'id': testId,
      'image': testImage,
      'type': testType,
      'userName': testUserName,
      'phone': testPhone,
      'email': testEmail,
      'fcmToken': testFcmToken,
    };

    test('should create UserAndAdminModelDto with correct properties', () {
      // Arrange & Act
      final user = UserAndAdminModelDto(
        id: testId,
        image: testImage,
        type: testType,
        userName: testUserName,
        phone: testPhone,
        email: testEmail,
        fcmToken: testFcmToken,
      );

      // Assert
      expect(user.id, equals(testId));
      expect(user.image, equals(testImage));
      expect(user.type, equals(testType));
      expect(user.userName, equals(testUserName));
      expect(user.phone, equals(testPhone));
      expect(user.email, equals(testEmail));
      expect(user.fcmToken, equals(testFcmToken));
    });

    test('toFireStore() should return correct Map representation', () {
      // Arrange
      final user = UserAndAdminModelDto(
        id: testId,
        image: testImage,
        type: testType,
        userName: testUserName,
        phone: testPhone,
        email: testEmail,
        fcmToken: testFcmToken,
      );

      // Act
      final result = user.toFireStore();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], equals(testId));
      expect(result['image'], equals(testImage));
      expect(result['type'], equals(testType));
      expect(result['userName'], equals(testUserName));
      expect(result['phone'], equals(testPhone));
      expect(result['email'], equals(testEmail));
      expect(result['fcmToken'], equals(testFcmToken));
    });

    test('fromFireStore() should create UserAndAdminModelDto from Map', () {
      // Act
      final user = UserAndAdminModelDto.fromFireStore(testUserData);

      // Assert
      expect(user, isA<UserAndAdminModelDto>());
      expect(user.id, equals(testId));
      expect(user.image, equals(testImage));
      expect(user.type, equals(testType));
      expect(user.userName, equals(testUserName));
      expect(user.phone, equals(testPhone));
      expect(user.email, equals(testEmail));
      expect(user.fcmToken, equals(testFcmToken));
    });

    test('fromFireStore() should handle null fcmToken', () {
      // Arrange
      final dataWithNullToken = {
        'id': testId,
        'image': testImage,
        'type': testType,
        'userName': testUserName,
        'phone': testPhone,
        'email': testEmail,
        'fcmToken': null,
      };

      // Act
      final user = UserAndAdminModelDto.fromFireStore(dataWithNullToken);

      // Assert
      expect(user, isA<UserAndAdminModelDto>());
      expect(user.fcmToken, isNull);
    });

    test('toFireStore() and fromFireStore() should be symmetric', () {
      // Arrange
      final originalUser = UserAndAdminModelDto(
        id: testId,
        image: testImage,
        type: testType,
        userName: testUserName,
        phone: testPhone,
        email: testEmail,
        fcmToken: testFcmToken,
      );

      // Act
      final map = originalUser.toFireStore();
      final recreatedUser = UserAndAdminModelDto.fromFireStore(map);

      // Assert
      expect(recreatedUser.id, equals(originalUser.id));
      expect(recreatedUser.image, equals(originalUser.image));
      expect(recreatedUser.type, equals(originalUser.type));
      expect(recreatedUser.userName, equals(originalUser.userName));
      expect(recreatedUser.phone, equals(originalUser.phone));
      expect(recreatedUser.email, equals(originalUser.email));
      expect(recreatedUser.fcmToken, equals(originalUser.fcmToken));
    });
  });
}
