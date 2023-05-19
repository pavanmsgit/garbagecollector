import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garbagecollector/controllers/itemsController.dart';
import 'package:garbagecollector/controllers/posterController.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:garbagecollector/const/appColors.dart';
import 'package:garbagecollector/controllers/authController.dart';
import 'package:garbagecollector/controllers/launch_controller.dart';
import 'package:garbagecollector/controllers/notificationController.dart';
import 'package:garbagecollector/controllers/spacesController.dart';
import 'package:garbagecollector/views/splash_screen.dart';
import 'package:garbagecollector/widgets/willPopBottomSheet.dart';
import 'controllers/homeController.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(SpacesController());
  Get.put(ItemsController());
  Get.put(LaunchController());
  Get.put(PosterController());
  Get.put(NotificationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    // final pushNotificationService = NotificationService(firebaseMessaging);
    // pushNotificationService.initialise();

    return WillPopScope(
      onWillPop: () => onWillPop(context),

      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Garbage Collector',
        color: AppColor.primaryColor,
        theme: ThemeData(
          primaryColor: AppColor.primaryColor,
          appBarTheme:const AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


