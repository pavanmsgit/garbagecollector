import 'package:flutter/material.dart';
import 'package:garbagecollector/const/appColors.dart';
import 'package:garbagecollector/const/appImages.dart';
import 'package:garbagecollector/const/screen_size.dart';
import 'package:garbagecollector/controllers/authController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///CHECKS AUTHENTICATION STATUS
    authController.checkAuth();
    authController.getUserProfile();

    return Scaffold(

      body: Container(
        color: AppColor.tertiaryColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(),
            Expanded(
              child:CircleAvatar(
                backgroundColor: AppColor.tertiaryColor,
                radius: ScreenSize.width(context) * 0.25,
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    height: ScreenSize.height(context) * 0.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
