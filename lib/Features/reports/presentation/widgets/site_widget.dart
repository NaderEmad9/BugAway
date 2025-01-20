import 'package:bug_away/Core/utils/font_manager.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bug_away/Core/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SiteWidget extends StatelessWidget {
  final String siteName;
  final String siteLocation;
  final VoidCallback onClicked;

  const SiteWidget({
    super.key,
    required this.siteName,
    required this.siteLocation,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: const BoxDecoration(color: ColorManager.whiteColor),
          child: ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.share_location_sharp,
                color: ColorManager.primaryColor,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                siteName,
                style: Theme.of(context).textTheme.headlineLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: StringManager.location,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s14,
                              color: ColorManager.primaryColor),
                    ),
                    TextSpan(
                      text: siteLocation,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            trailing: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: FaIcon(
                FontAwesomeIcons.circleChevronRight,
                color: ColorManager.primaryColor,
              ),
            ),
            onTap: onClicked,
          ),
        ),
      ),
    );
  }
}
