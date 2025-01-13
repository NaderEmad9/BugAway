import 'package:bug_away/Core/utils/strings.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val == null || val.trim().isEmpty) {
      return StringManager.requiredField;
    } else if (!emailRegex.hasMatch(val)) {
      return StringManager.badFormat;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
      return StringManager.strongPassword;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else if (val != password) {
      return StringManager.samePassword;
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else if (!usernameRegex.hasMatch(val)) {
      return StringManager.enterValidUsername;
    } else {
      return null;
    }
  }

  static String? validateSite(String? val) {
    if (val == null || val.trim().isEmpty) {
      return StringManager.requiredField;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return StringManager.requiredField;
    } else if (int.tryParse(val.trim()) == null) {
      return StringManager.enterValidNumber;
    } else if (val.trim().length > 15) {
      return StringManager.enterValidNumberDigit;
    } else {
      return null;
    }
  }
}
