import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:bug_away/Features/user_request_account/domain/use_cases/user_request_account_use_case.dart';

import '../../../../Core/errors/failures.dart';

part 'user_request_account_view_model_state.dart';

@injectable
class UserRequestAccountCubit extends Cubit<UserRequestAccountState> {
  final Logger _logger = Logger('UserRequestAccountCubit');
  UserRequestAccountUseCase userRequestAccountUseCase;
  UserRequestAccountCubit({required this.userRequestAccountUseCase})
      : super(UserRequestAccountViewModelInitial());
  static UserRequestAccountCubit get(context) =>
      BlocProvider.of<UserRequestAccountCubit>(context);

  //===============Variables Handle=======================
  List<String> list = ["admin", "user"];
  String? selectedValue;
  bool isLoaded = false;
  var fromKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");

  //===============Image Profile Handle===================
  final ImagePicker picker = ImagePicker();
  File? image;
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(UserRequestAccountViewModelChangeImage());
    } else {
      image = null;
      emit(UserRequestAccountViewModelChangeImage());
    }
  }

  //===============Animation Handle=======================
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  double opacity = 0.0;

  void doAnimation(SingleTickerProviderStateMixin single) {
    animationController = AnimationController(
        vsync: single, duration: const Duration(seconds: 1));

    slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      opacity = 1.0;
      emit(UserRequestAccountViewModelAnimation());
      animationController.forward();
    });
  }

  //==========Defualt DropDownValue Handle===============
  void initValueDropDown() {
    selectedValue = list[0];
  }

  //===============UserRequestAccount Handle=======================
  Future<void> userRequestAccount() async {
    isLoaded = true;
    emit(UserRequestAccountViewModelLoading());
    var either = await userRequestAccountUseCase.userRequestAccountFireStore(
        image?.path ?? "",
        selectedValue ?? "admin",
        userNameController.text,
        phoneController.text,
        emailController.text,
        passwordController.text);
    either.fold((error) {
      isLoaded = false;
      _logger.severe('Error: ${error.errorMessage}');
      emit(UserRequestAccountViewModelError(failure: error));
    }, (response) {
      isLoaded = false;
      emit(UserRequestAccountViewModelSuccess());
      clearData();
    });
  }

  //===============Close Screen Handle=====================

  void clearData() {
    userNameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    // animationController.dispose();
    image = null;
  }
}
