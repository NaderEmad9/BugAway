import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bug_away/Core/utils/colors.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:bug_away/Features/site_report/presentation/manager/report_view_model.dart';
import 'package:bug_away/Core/component/button_custom.dart';

class ConditionsScreen extends StatefulWidget {
  const ConditionsScreen({super.key});

  @override
  State<ConditionsScreen> createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen>
    with SingleTickerProviderStateMixin {
  final int maxCharacters = 500;
  String inputText = '';
  final TextEditingController _conditionsController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 2.h), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Trigger the slide animation after the page loads
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reportViewModel = context.read<ReportViewModel>();
    _conditionsController.text = reportViewModel.conditions;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportViewModel = context.read<ReportViewModel>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(StringManager.conditions,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.all(22.0.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: TextField(
                  controller: _conditionsController,
                  maxLength: maxCharacters,
                  onChanged: (text) {
                    setState(() {
                      inputText = text;
                    });
                    reportViewModel.updateConditions(text);
                  },
                  cursorColor: ColorManager.primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.whiteColor,
                    hintText: StringManager.enterConditions,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ColorManager.greyShade4),
                    counterStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: ColorManager.greyShade4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  ),
                  maxLines: 15,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: ButtonCustom(
                  buttonName: StringManager.save,
                  onTap: () {
                    Navigator.pop(context, _conditionsController.text);
                  },
                  textStyle: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
