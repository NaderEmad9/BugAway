import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bug_away/Config/routes/routes_manger.dart';
import 'package:bug_away/Core/utils/colors.dart';
import 'package:bug_away/Core/utils/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Core/utils/font_manager.dart';
import '../../../register/data/models/user_model_dto.dart';
import '../../../reports/domain/entities/site_entity.dart';
import '../manager/site_view_model.dart';

class SiteInfoItem extends StatelessWidget {
  final SiteEntity site;
  final Function()? onDelete;
  final bool isAdmin;

  const SiteInfoItem({
    super.key,
    required this.site,
    required this.onDelete,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Slidable(
          dragStartBehavior: DragStartBehavior.down,
          endActionPane: isAdmin
              ? ActionPane(
                  dragDismissible: false,
                  motion: const BehindMotion(),
                  extentRatio: .18,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        onDelete!();
                      },
                      backgroundColor: ColorManager.primaryColor,
                      foregroundColor: ColorManager.whiteColor,
                      icon: Icons.delete,
                    ),
                  ],
                )
              : null,
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
                  site.siteName.toString(),
                  style: Theme.of(context).textTheme.headlineLarge,
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
                        text: site.siteLocation.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
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
              onTap: () {
                SiteViewModel.get(context).user.type ==
                        UserAndAdminModelDto.user
                    ? Navigator.pushNamed(
                        context,
                        RoutesManger.routeNameSiteReportScreen,
                        arguments: {
                          'siteName': site.siteName,
                          'siteId': site.siteId
                        },
                      )
                    : Navigator.pushNamed(
                        context, RoutesManger.routeNameReportOfSiteScreen,
                        arguments: site.siteId);
              },
            ),
          ),
        ),
      ),
    );
  }
}
