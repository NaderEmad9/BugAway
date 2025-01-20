import 'package:bug_away/Core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:bug_away/Core/component/search_field_widget.dart';
import 'package:bug_away/Core/utils/colors.dart';
import 'package:bug_away/Features/site/presentation/manager/site_state.dart';
import 'package:bug_away/Features/site/presentation/manager/site_view_model.dart';

import '../../../../Core/component/custom_dialog.dart';
import '../../../../Core/component/lottie_loading_widget.dart';
import '../../../../Core/utils/strings.dart';
import '../widgets/add_new_site.dart';
import '../widgets/site_info_item.dart';
import '../../../../Core/component/empty_pages.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen>
    with SingleTickerProviderStateMixin {
  late SiteViewModel bloc;
  bool showEmptyState = false;

  @override
  void initState() {
    bloc = SiteViewModel.get(context);
    bloc.user = bloc.getUser()!;
    bloc.fetchSite();
    bloc.fetchUsers();
    bloc.fetchUserSites();
    bloc.doAnimation(this);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showEmptyState = true;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    bloc.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SiteViewModel, SiteState>(
      listener: (context, state) {
        if (state is SiteErrorState) {
          DialogUtils.showAlertDialog(
            context: context,
            title: StringManager.failed,
            message: state.failure.errorMessage,
            posActionTitle: StringManager.ok,
          );
        }
        if (state is UsersSiteErrorState) {
          DialogUtils.showAlertDialog(
            context: context,
            title: StringManager.failed,
            message: state.failure.errorMessage,
            posActionTitle: StringManager.ok,
          );
        }
        if (state is AddSiteErrorState) {
          DialogUtils.showAlertDialog(
            context: context,
            title: StringManager.failed,
            message: state.failure.errorMessage,
            posActionTitle: StringManager.ok,
          );
        }
        if (state is AddSiteSuccessState) {
          DialogUtils.showAlertDialog(
            context: context,
            title: StringManager.success,
            message: StringManager.siteAddSuccess,
            posActionTitle: StringManager.ok,
          );
        }
        if (state is DeleteSiteSuccessState) {
          DialogUtils.showAlertDialog(
            context: context,
            title: StringManager.success,
            message: StringManager.siteDeleteSuccess,
            posActionTitle: StringManager.ok,
          );
        }
        if (state is GetUserSiteErrorState) {
          DialogUtils.showAlertDialog(
            context: context,
            title: StringManager.failed,
            message: state.failure.errorMessage,
            posActionTitle: StringManager.ok,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text(StringManager.sites),
            actions: [
              if (bloc.user.type == 'admin')
                IconButton(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
                    size: 26,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddNewSite(),
                    );
                  },
                ),
            ],
          ),
          body: ModalProgressHUD(
            opacity: 0.4,
            color: ColorManager.greyShade3,
            inAsyncCall: bloc.isLoading,
            progressIndicator: const Center(child: LottieLoadingWidget()),
            child: Column(
              children: [
                SearchFieldWidget(
                  controller: bloc.searchController,
                  onChanged: (value) {
                    bloc.filterSites(value);
                  },
                ),
                Expanded(
                  child: state is SiteLoadingState
                      ? Container()
                      : state is SiteErrorState
                          ? const Center(
                              child: EmptyStateWidget(
                                lottiePath: ImageManager.emptySearchLottie,
                                message: StringManager.noSitesFound,
                              ),
                            )
                          : bloc.searchedSites.isEmpty
                              ? const Center(
                                  child: EmptyStateWidget(
                                    lottiePath: ImageManager.emptySearchLottie,
                                    message: StringManager.noSitesFound,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: bloc.searchedSites.length,
                                  itemBuilder: (context, index) {
                                    final site = bloc.searchedSites[index];
                                    return SiteInfoItem(
                                      site: site,
                                      onDelete: () {
                                        bloc.deleteSite(site);
                                      },
                                      isAdmin: bloc.user.type == 'admin',
                                    );
                                  },
                                ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
