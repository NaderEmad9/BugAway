import 'dart:io';
import 'package:bug_away/Core/utils/fcm_helper.dart';
import 'package:logging/logging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:bug_away/Core/errors/failures.dart';
import 'package:bug_away/Core/utils/firebase_utils.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:bug_away/Features/register/data/models/user_model_dto.dart';
import 'package:bug_away/Features/user_request_account/data/data_source/data/user_request_account_data_source.dart';
import 'package:bug_away/Features/user_request_account/data/models/user_request_account_model_dto.dart';

@Injectable(as: UserRequestAccountDataSource)
class UserRequestAccountDataSourceImpl implements UserRequestAccountDataSource {
  final Logger _logger = Logger('UserRequestAccountDataSourceImpl');

  static Future<void> addUserRequestAccountToFireStore(
      UserRequestAccountDto user) async {
    var collection = FirebaseUtils.getUserRequestAccountCollection(
        UserRequestAccountDto.requests);
    var docs = collection.doc();
    user.id = docs.id;
    return docs.set(user);
  }

  Future<bool> doesEmailExist(String email, String collectionName) async {
    try {
      var userCollection =
          FirebaseFirestore.instance.collection(collectionName);
      var querySnapshot =
          await userCollection.where('email', isEqualTo: email).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      _logger.severe('Error checking email existence: $e');
      return false;
    }
  }

  static Future<List<List<String>?>> getAdminTokenFromFireStore() async {
    var docSnapshot =
        await FirebaseUtils.getUserCollection(UserAndAdminModelDto.admin).get();
    var data = docSnapshot.docs;

    List<List<String>?> list = data.map((e) {
      return e.data().fcmToken;
    }).toList();
    return list;
  }

  @override
  Future<Either<Failure, void>> userRequestAccountAuth(
    String? imagePath,
    String type,
    String userName,
    String phone,
    String email,
    String password,
  ) async {
    try {
      bool checkEmailInUsers =
          await doesEmailExist(email, UserAndAdminModelDto.user);
      bool checkEmailInAdmins =
          await doesEmailExist(email, UserAndAdminModelDto.admin);
      bool checkEmailInRequests =
          await doesEmailExist(email, UserRequestAccountDto.requests);
      if (checkEmailInUsers == false &&
          checkEmailInAdmins == false &&
          checkEmailInRequests == false) {
        String imageUrl = "";
        if (imagePath != null && imagePath.isNotEmpty) {
          final result =
              await FirebaseUtils.addImageToFirebaseStorage(File(imagePath));
          result.fold(
            (_) {},
            (url) => imageUrl = url,
          );
        }
        UserRequestAccountDto userRequestAccountDto = UserRequestAccountDto(
            image: imageUrl,
            type: type,
            userName: userName,
            phone: phone,
            email: email,
            password: password,
            dateTime: DateTime.now());

        await addUserRequestAccountToFireStore(userRequestAccountDto);
        String title = "New Request Account Available";
        String body =
            "(${userRequestAccountDto.userName}) has sent an account request to admins. Check your request screen.";
        List<UserAndAdminModelDto> adminList =
            await FirebaseUtils.getAdminOrUserTokenFromFireStore(
                UserAndAdminModelDto.admin);

        for (var admin in adminList) {
          if (admin.fcmToken != null) {
            var tokens = admin.fcmToken!;
            try {
              for (var token in tokens) {
                await NotificationService.sendNotification(
                    deviceToken: token, title: title, body: body);
              }
            } catch (e) {
              _logger.severe('Error sending notification: $e');
            }
          }
        }
      } else {
        return Left(Failure(errorMessage: StringManager.emailInUse));
      }

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      _logger.severe('FirebaseAuthException: $e');
      if (e.code == 'invalid-credential') {
        return Left(Failure(errorMessage: StringManager.badFormat));
      } else if (e.code == 'email-already-in-use') {
        return Left(Failure(errorMessage: StringManager.emailInUse));
      } else if (e.code == 'network-request-failed') {
        return Left(Failure(errorMessage: StringManager.networkError));
      } else {
        return Left(Failure(errorMessage: StringManager.somethingWentWrong));
      }
    } catch (e) {
      _logger.severe('Unexpected error: $e');
      return Left(Failure(errorMessage: StringManager.somethingWentWrong));
    }
  }
}
