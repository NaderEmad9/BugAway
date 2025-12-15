import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:bug_away/Features/login/data/repositories/login_repository_impl.dart';
import 'package:bug_away/Features/login/data/data_sources/login_data_source.dart';
import 'package:bug_away/Features/register/data/models/user_model_dto.dart';
import 'package:bug_away/Core/errors/failures.dart';

// Mock LoginDataSource for testing
class MockLoginDataSource implements LoginDataSource {
  Either<Failure, UserAndAdminModelDto?>? mockResult;
  String? lastEmail;
  String? lastPassword;
  String? lastType;

  void setMockResult(Either<Failure, UserAndAdminModelDto?> result) {
    mockResult = result;
  }

  @override
  Future<Either<Failure, UserAndAdminModelDto?>> login(
      String email, String password, String? type) async {
    lastEmail = email;
    lastPassword = password;
    lastType = type;
    return mockResult!;
  }
}

void main() {
  group('LoginRepositoryImpl', () {
    late LoginRepositoryImpl repository;
    late MockLoginDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockLoginDataSource();
      repository = LoginRepositoryImpl(loginDataSource: mockDataSource);
    });

    test('should return user when login is successful', () async {
      // Arrange
      final expectedUser = UserAndAdminModelDto(
        id: 'user-123',
        email: 'test@example.com',
        userName: 'Test User',
        phone: '+1234567890',
        type: 'admin',
        image: 'https://example.com/image.png',
        fcmToken: ['token1'],
      );
      mockDataSource.setMockResult(Right(expectedUser));

      // Act
      final result = await repository.login(
        'test@example.com',
        'password123',
        'admin',
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (user) {
          expect(user?.email, equals('test@example.com'));
          expect(user?.userName, equals('Test User'));
          expect(user?.type, equals('admin'));
        },
      );
    });

    test('should return failure when login fails', () async {
      // Arrange
      final expectedFailure = ServerFailure(errorMessage: 'Invalid credentials');
      mockDataSource.setMockResult(Left(expectedFailure));

      // Act
      final result = await repository.login(
        'wrong@example.com',
        'wrongpassword',
        'admin',
      );

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure.errorMessage, equals('Invalid credentials'));
        },
        (user) => fail('Expected Left but got Right'),
      );
    });

    test('should pass correct parameters to data source', () async {
      // Arrange
      mockDataSource.setMockResult(Right(null));
      const testEmail = 'test@example.com';
      const testPassword = 'password123';
      const testType = 'engineer';

      // Act
      await repository.login(testEmail, testPassword, testType);

      // Assert
      expect(mockDataSource.lastEmail, equals(testEmail));
      expect(mockDataSource.lastPassword, equals(testPassword));
      expect(mockDataSource.lastType, equals(testType));
    });

    test('should return null user when user not found', () async {
      // Arrange
      mockDataSource.setMockResult(const Right(null));

      // Act
      final result = await repository.login(
        'notfound@example.com',
        'password123',
        'admin',
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (user) {
          expect(user, isNull);
        },
      );
    });

    test('should handle network failure', () async {
      // Arrange
      final networkFailure = NetworkFailure(errorMessage: 'No internet connection');
      mockDataSource.setMockResult(Left(networkFailure));

      // Act
      final result = await repository.login(
        'test@example.com',
        'password123',
        'admin',
      );

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.errorMessage, equals('No internet connection'));
        },
        (user) => fail('Expected Left but got Right'),
      );
    });
  });
}
