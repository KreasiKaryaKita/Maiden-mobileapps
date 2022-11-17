import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maiden_employer/app/config/constants/app_constant.dart';
import 'package:maiden_employer/app/models/entity/helpers_model.dart';
import 'package:maiden_employer/app/routes/app_pages.dart';
import 'package:maiden_employer/app/shared/widgets/images/cached_network_image_widget.dart';
import 'package:maiden_employer/app/shared/widgets/loading/loading_widget.dart';
import 'package:maiden_employer/app/shared/widgets/organism/header_filter_result.dart';
import 'package:maiden_employer/app/shared/widgets/organism/header_helper_listigs.dart';
import 'package:maiden_employer/app/shared/widgets/organism/helper_listing_empty.dart';

import '../controllers/helper_listing_controller.dart';

class HelperListingView extends GetView<HelperListingController> {
  const HelperListingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF820333),
              const Color(0xFF540032),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: Obx(
          () => Column(
            children: [
              if (controller.isFiltered.value) HeaderFilterResult(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    if (controller.isFiltered.value && controller.helpers.isNotEmpty)
                      Text(
                        "${'filter_browsing'.tr.toUpperCase()} 300 ${'filter_results'.tr.toUpperCase()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ).marginOnly(top: 4),
                    if (!controller.isFiltered.value) HeaderHelperListings(),
                    LoadingWidget(
                      isLoading: false,
                      data: controller.helpers,
                      emptyChild: HelperListingEmpty().paddingSymmetric(horizontal: 20),
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: Get.width / 2,
                          childAspectRatio: 1 / 1.7,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: controller.helpers.length,
                        itemBuilder: (BuildContext ctx, index) {
                          HelpersModel item = controller.helpers[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_HELPER);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      child: CachedNetworkImageWidget(
                                        url: item.image ?? AppConstant.DEFAULT_AVATAR,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name ?? "n/a",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Color(0xFF272B30),
                                                        fontFamily: AppConstant.CENTURY_GOTHIC_FONT,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 13,
                                                      ),
                                                    ).marginOnly(bottom: 4),
                                                    Text(
                                                      "${item.age ?? "0"} ${'years_old'.tr}",
                                                      style: TextStyle(
                                                        color: Color(0xFF272B30),
                                                        fontFamily: AppConstant.SF_PRO_FONT,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 11,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                "assets/images/icon-country-${item.country}.svg",
                                                height: 20,
                                              )
                                            ],
                                          ).paddingSymmetric(horizontal: 16, vertical: 10),
                                          Divider(
                                            thickness: 1,
                                            height: 0,
                                            color: Color(0xFFDEE2E6),
                                          ).paddingSymmetric(horizontal: 16),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${item.experience ?? "0"} ${'years_experience'.tr}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xFF272B30),
                                                  fontFamily: AppConstant.SF_PRO_FONT,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
                                                ),
                                              ).marginOnly(bottom: 6),
                                              Row(
                                                children: [
                                                  Text(
                                                    'ready_from'.tr,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFFADB5BD),
                                                      fontFamily: AppConstant.SF_PRO_FONT,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      DateFormat('dd MMM yyyy', Get.locale.toString()).format(
                                                        item.readyDate ?? DateTime.now(),
                                                      ),
                                                      textAlign: TextAlign.right,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Color(0xFFADB5BD),
                                                        fontFamily: AppConstant.SF_PRO_FONT,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ).paddingSymmetric(horizontal: 16, vertical: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
