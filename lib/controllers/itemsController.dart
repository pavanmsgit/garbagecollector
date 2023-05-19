// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:garbagecollector/controllers/authController.dart';
import 'package:garbagecollector/models/userModel.dart';
import 'package:garbagecollector/preferences/userDataPrefs.dart';
import 'package:garbagecollector/services/itemService.dart';
import 'package:garbagecollector/widgets/spinner.dart';
import 'package:garbagecollector/widgets/toastMessage.dart';

import '../models/spaces.dart';

final ItemsController itemsController = Get.find<ItemsController>();

class ItemsController extends GetxController {
  RxBool phoneAvailable = true.obs,
      loginObscure = false.obs,
      registerPasswordObscure = false.obs,
      registerConfirmObscure = false.obs;

  TextEditingController spaceNameController = TextEditingController(),
      spaceDescriptionController = TextEditingController(),
      spaceCapacityController = TextEditingController(),
      chatsController = TextEditingController();

  FocusNode spaceNameNode = FocusNode(),
      spaceDescriptionNode = FocusNode(),
      spaceCapacityNode = FocusNode();

  String selectedArea = "";

  final GlobalKey<FormState> createSpaceKey = GlobalKey<FormState>(),
      updateSpaceKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  SpacesService spacesService = SpacesService();
  UserData userData = UserData();

  var rand = Random();

  File? spacesImageFile;
  String? spacesImageFileName;

  RxInt currentCapacity = 0.obs;

  List<UserModel> spaceUsersList = [];
  RxBool addUsersButtonStatus = false.obs;


  Future checkSpaceCurrentCapacity({required var spaceCapacity,required String spaceDocId}) async {
    var res = await FirebaseFirestore
        .instance
        .collection('spaces')
        .doc(spaceDocId)
        .collection("members")
        .get();

    currentCapacity.value = spaceCapacity - res.docs.length;
    update();
  }


  ///UPDATES THE BOTTOM BAR STATUS
  updateStatusForBottomButton() {
    if (spaceUsersList.isEmpty) {
      addUsersButtonStatus.value = false;
    } else {
      addUsersButtonStatus.value = true;
    }
    update();
  }

  ///SENDS A MESSAGE TO THE GROUP
  sendMessage({required String spaceDocId}) {
    String referenceId =
        rand.nextInt(10000).toString() + rand.nextInt(10000).toString();

    if (chatsController.text.isEmpty) {
      showToast("Please enter the message", ToastGravity.CENTER);
      return;
    }

    try {
      var res = spacesService.addMessageToTheSpace(
          spaceDocId: spaceDocId,
          referenceId: referenceId,
          user: authController.profile!,
          message: chatsController.text);

      chatsController.clear();

    } catch (err) {
      showToast(err.toString(), ToastGravity.BOTTOM);
    }
  }

  ///SELECTS A IMAGE FILE FROM THE FILES
  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      spacesImageFile = File(img.path);
      update();
    }
  }

  ///CREATES A NEW SPACE
  createItem() async {
    String notificationId =
        rand.nextInt(10000).toString() + rand.nextInt(10000).toString();


    try {
      showSpinner();

      bool res = await spacesService.createItemDB(
          notificationId: notificationId,
          title: spaceNameController.text,
          description: spaceDescriptionController.text,
          area: itemsController.selectedArea,
          time: DateTime.now());

      if (res) {
        showToast('Added', ToastGravity.BOTTOM);
        clearAllSpacesFields();
        Get.back();
      }
    } catch (err) {
      showToast(err.toString(), ToastGravity.BOTTOM);
    }
    hideSpinner();
  }

  ///CLEARS ALL THE INPUTS FROM THE USER AFTER CREATING A SPACE
  clearAllSpacesFields() {
    spaceNameController.clear();
    spaceDescriptionController.clear();
    selectedArea = "";
    update();
  }


  ///REMOVE FROM SPACE USER LIST
  removeFromSpaceUserList({required UserModel user}) {
    spaceUsersList.remove(user);
    update();
  }

  ///UPDATE SPACE USERS DOCUMENT
  updateSpaceUsers({required String spaceDocId,required Notifications space}) async {

  }

  ///CLEARS THE ARRAY
  clearSpaceUserList() {
    spaceUsersList.clear();
    currentCapacity.value = 0;
    update();
    Get.back();
  }
}
