import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:garbagecollector/const/screen_size.dart';
import 'package:garbagecollector/controllers/homeController.dart';
import 'package:garbagecollector/const/appColors.dart';

titleAppBar(
    {required BuildContext context, Widget? tabBars, List<Widget>? actions}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100.0),
    child: Container(
      width: ScreenSize.width(context),
      decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          )),
      child: AppBar(
        actions: actions ?? [],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Obx(
          () => AutoSizeText(homeController.appBarTitles
              .elementAt(homeController.selectedTab.value),style: const TextStyle(color: AppColor.tertiaryColor),),
        ),
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: tabBars ??
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                  child: Obx(() => AutoSizeText(
                        homeController.appBarSubTitles
                            .elementAt(homeController.selectedTab.value),
                        style: const TextStyle(
                            color: AppColor.tertiaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ),
        ),
      ),
    ),
  );
}




class SliverAppBarLogo extends StatelessWidget{
  SliverAppBarLogo({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      floating: false,
      stretch: false,
      //pinned: true,
      toolbarHeight: 50,
      leading: Container(),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(bottom: 10),
          // It will cover 20% of our total height
          //height: ScreenSize.height(context) * 0.2,
          child: Stack(
            children: <Widget>[
              //THE TOP COLOR BAR
              Container(
                height: ScreenSize.height(context) * 0.01,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0),
                  height: 0,
                  decoration: const BoxDecoration(
                    color: AppColor.greyLight,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(0, 5),
                    //     blurRadius: 25,
                    //     color: AppColor.primaryColor.withOpacity(0.2),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 5, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 5),
                          child: Center(
                              child: Text(
                                title ?? "COST",
                                style: TextStyle(
                                    color: AppColor.blackMild,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ),
                        Container(
                          width: ScreenSize.width(context) * 0.75,
                          child: Divider(
                            height:
                            ScreenSize.height(context) * 0.01,
                            thickness: 2,
                            color:
                            AppColor.black.withOpacity(0.4),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: 75,
      collapsedHeight: 50,
      backgroundColor: Colors.transparent,
      //pinned: false,
      elevation: 3.0,
    );
  }
}





titleAppBarWithBackButton(
    {required String? title,
    required String? subTitle,
    Function()? onPress,
    required BuildContext context,
    Widget? tabBars,
    List<Widget>? actions}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100.0),
    child: Container(
      width: ScreenSize.width(context),
      decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          )),
      child: AppBar(
        actions: actions ?? [],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.tertiaryColor,
            size: 30,
          ),
          onPressed: onPress ??
              () {
                Get.back();
              },
        ),
        centerTitle: true,
        title: AutoSizeText(
          title ?? '',
          style: const TextStyle(
              color: AppColor.tertiaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: tabBars ??
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AutoSizeText(
                  subTitle ?? '',
                  style: const TextStyle(
                      color: AppColor.tertiaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
        ),
      ),
    ),
  );
}


