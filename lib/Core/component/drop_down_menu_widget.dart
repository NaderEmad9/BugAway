import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';

class DropDownMenuWidget extends StatelessWidget {
  final List<String> list;
  final String? selectedValue;
  final Function(String?) onChange;

  const DropDownMenuWidget({
    super.key,
    required this.list,
    required this.selectedValue,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: DropdownButtonFormField<String>(
        items: list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              _getDisplayValue(value),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          onChange(value);
        },
        value: selectedValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: ColorManager.whiteColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: ColorManager.whiteColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: ColorManager.whiteColor,
              width: 1,
            ),
          ),
        ),
        dropdownColor: ColorManager.backgroundColor,
        iconEnabledColor: ColorManager.whiteColor,
      ),
    );
  }

  String _getDisplayValue(String value) {
    switch (value) {
      case 'admin':
        return StringManager.manager;
      case 'user':
        return StringManager.engineer;
      default:
        return value;
    }
  }
}
