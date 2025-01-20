import 'package:bug_away/Config/routes/routes_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:bug_away/Core/component/button_custom.dart';
import 'package:bug_away/Core/component/text_feild_custom.dart';
import 'package:bug_away/Core/utils/colors.dart';
import 'package:bug_away/Core/utils/images.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:bug_away/Features/forgotPassword/presentation/manager/forget_password_state.dart';
import 'package:bug_away/Features/forgotPassword/presentation/manager/forget_password_view_model.dart';
import 'package:bug_away/di/di.dart';

import '../../../../Core/component/custom_dialog.dart';
import '../../../../Core/component/lottie_loading_widget.dart';
import '../../../../Core/component/validators.dart';

class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({super.key});
  final ForgetPasswordViewModel viewModel = getIt<ForgetPasswordViewModel>();

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    ForgetPasswordViewModel.get(context).doAnimation(this);
    ForgetPasswordViewModel.get(context).opacity = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordErrorState) {
            DialogUtils.showAlertDialog(
                context: context,
                title: StringManager.error,
                message: state.failure.errorMessage,
                posActionTitle: StringManager.ok);
          } else if (state is ForgetPasswordSuccessState) {
            DialogUtils.showAlertDialog(
                context: context,
                title: StringManager.success,
                message: StringManager.resetEmailSucess,
                posActionTitle: StringManager.ok);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            opacity: 0.4,
            color: ColorManager.greyShade3,
            inAsyncCall: ForgetPasswordViewModel.get(context).isLoading,
            progressIndicator: const LottieLoadingWidget(),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(StringManager.forgotPass,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              body: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageManager.background),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Form(
                          key: ForgetPasswordViewModel.get(context)
                              .forgetPasswordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 40.h),
                                  AnimatedOpacity(
                                    opacity:
                                        ForgetPasswordViewModel.get(context)
                                            .opacity,
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.easeIn,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 26.0),
                                      child: Image.asset(
                                        ImageManager.logoTeam,
                                        height: 96.h,
                                        // width: 180.w,
                                        // fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 125.h),
                                  AnimatedOpacity(
                                    duration: const Duration(seconds: 2),
                                    opacity:
                                        ForgetPasswordViewModel.get(context)
                                            .opacity,
                                    curve: Curves.easeIn,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(StringManager.resetPassEmail,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SlideTransition(
                                    position:
                                        ForgetPasswordViewModel.get(context)
                                            .slideAnimation,
                                    child: CustomTextFormField(
                                      hint: StringManager.enterEmailHint,
                                      validator: (val) =>
                                          AppValidators.validateEmail(val),
                                      controller:
                                          ForgetPasswordViewModel.get(context)
                                              .emailController,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  SlideTransition(
                                    position:
                                        ForgetPasswordViewModel.get(context)
                                            .slideAnimation,
                                    child: ButtonCustom(
                                      buttonName: StringManager.send,
                                      enable: true,
                                      onTap: () {
                                        if (ForgetPasswordViewModel.get(context)
                                            .forgetPasswordFormKey
                                            .currentState!
                                            .validate()) {
                                          ForgetPasswordViewModel.get(context)
                                              .forgetPassword();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 55.h),
                                  AnimatedOpacity(
                                    duration: const Duration(seconds: 2),
                                    opacity:
                                        ForgetPasswordViewModel.get(context)
                                            .opacity,
                                    curve: Curves.easeIn,
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutesManger
                                                      .routeNameUserRequestAccount);
                                            },
                                            child: Text(
                                                StringManager.requestAccount,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      color: ColorManager
                                                          .whiteColor,
                                                    ))),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                "${StringManager.alreadyHaveAccount} ${StringManager.login} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      color: ColorManager
                                                          .whiteColor,
                                                    ))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
