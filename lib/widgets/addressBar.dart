import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbagecollector/widgets/shimmer.dart';
import 'package:get/get.dart';
import 'package:garbagecollector/const/screen_size.dart';

import '../const/appColors.dart';
import '../controllers/location_controller.dart';

class AddressBar extends StatefulWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {
  @override
  void initState() {
    //TODO - FIND AN ALTERNATIVE
    // Future.delayed(const Duration(milliseconds: 5000), () {
    //   assetController.updateAssetInfoForFilter(null);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   locationController.getLocationPermission();
    //   locationController.getLatestAddress().whenComplete(() => true);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LocationController(),
      builder: (_) => locationController.address.isEmpty
          ? const ShimmerForAddressBar()
          :

      ///ADDRESS BAR UI
      GestureDetector(
        onTap: () {

        },
        child: Container(
          color: AppColor.dark,
          height: 65,
          width: ScreenSize.width(context),
          margin: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      AutoSizeText(
                        "Current Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColor.blackMild),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColor.blackMild,
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          locationController.address,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColor.blackMild,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenSize.width(context) * 0.85,
                  child: Divider(
                    height: 10,
                    thickness: 1,
                    color: AppColor.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
