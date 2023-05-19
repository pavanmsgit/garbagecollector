import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garbagecollector/const/appColors.dart';
import 'package:garbagecollector/controllers/authController.dart';
import 'package:garbagecollector/controllers/homeController.dart';
import 'package:garbagecollector/preferences/userDataPrefs.dart';
import 'package:garbagecollector/widgets/appBars.dart';
import 'package:garbagecollector/widgets/appBottomNavBar.dart';
import 'package:garbagecollector/widgets/spinner.dart';
import 'package:garbagecollector/widgets/willPopBottomSheet.dart';


class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({Key? key}) : super(key: key);

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  final HomeController hc = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.getUserProfile();
    });
    super.initState();
  }

  var email;

  checkPrefs()async{
    email = await UserData().getUserEmail();
    debugPrint("THIS IS USER PHONE NUMBER $email");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Spinner(
        child: Scaffold(
          backgroundColor: AppColor.tertiaryColor,

          body: Obx(
                () => hc.screens.elementAt(hc.selectedTab.value),
          ),

          bottomNavigationBar: const AppBottomNav(),

        ),
      ),
    );
  }
}
