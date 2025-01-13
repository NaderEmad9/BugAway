import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String title;
  const CustomText({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 25.sp,
          ),
    );
  }
}
