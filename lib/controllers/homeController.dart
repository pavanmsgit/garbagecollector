import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbagecollector/services/authService.dart';
import 'package:garbagecollector/views/subScreens/accountScreen.dart';
import 'package:garbagecollector/views/subScreens/mainInfoScreen.dart';

final HomeController homeController = Get.find<HomeController>();

class HomeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxInt selectedTab = 0.obs;

  AuthService userService = AuthService();

  List appBarTitles = [
    'Notifier',
    'My Profile'
  ];

  List appBarSubTitles = [
    'Latest Updates',
    'Manage profile'
  ];

  List screens = [
    const SpacesScreen(),
    const AccountScreen()
  ];
}
