import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:garbagecollector/const/appColors.dart';
import 'package:garbagecollector/const/appImages.dart';
import 'package:garbagecollector/const/screen_size.dart';
import 'package:garbagecollector/controllers/authController.dart';
import 'package:garbagecollector/models/spaces.dart';
import 'package:garbagecollector/preferences/userDataPrefs.dart';
import 'package:garbagecollector/widgets/appBars.dart';
import 'package:get/get.dart';
import 'package:garbagecollector/widgets/shimmer.dart';
import 'package:intl/intl.dart';

import '../../controllers/launch_controller.dart';
import '../../controllers/location_controller.dart';
import '../../widgets/addressBar.dart';
import '../../widgets/posterWidget.dart';
import 'itemComponent/createItem.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  String user = "";
  UserData userData = UserData();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserData();
      authController.getUserProfile();
      locationController.getLocationPermission();
      locationController.getLatestAddress().whenComplete(() => true);
    });
    super.initState();
  }

  getUserData() async {
    user = await userData.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.greyLight,
        body: GetBuilder(
          init: AuthController(),
          builder: (_) => NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context),
                  sliver: SliverAppBar(
                    floating: true,
                    stretch: false,
                    //pinned: true,
                    toolbarHeight: 250,
                    leading: Container(),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: AppColor.greyLight,
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
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 5),
                                        child: Center(
                                            child: Text(
                                              "Home",
                                              style: TextStyle(
                                                  color: AppColor.blackMild,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                      ),
                                      SizedBox(
                                        width:
                                        ScreenSize.width(context) * 0.75,
                                        child: Divider(
                                          thickness: 2,
                                          color: AppColor.blackMild
                                              .withOpacity(0.4),
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
                    expandedHeight: 300,
                    collapsedHeight: 250,
                    backgroundColor: Colors.grey,
                    pinned: false,
                    elevation: 10.0,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(75),
                      child: Column(
                        children: [
                          ///POSTER CAROUSEL WIDGET
                          const PosterWidget(),

                          SizedBox(
                            width: ScreenSize.width(context) * 0.75,
                            child: Divider(
                              height: ScreenSize.height(context) * 0.01,
                              thickness: 2,
                              color: AppColor.blackMild.withOpacity(0.4),
                            ),
                          ),

                          ///LOADS CURRENT LOCATION DATA
                          const AddressBar(),

                          const SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: StreamBuilder<QuerySnapshot> (
              stream:  FirebaseFirestore.instance
                  .collection("items")
                  .limit(100)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data?.docs.length == 0) {
                  return const NoSpacesErrorPage();
                }

                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      const SliverPadding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            QueryDocumentSnapshot? data = snapshot.data?.docs[index];
                            final items = Notifications.fromSnapshot(data!);

                            return ListItemViewUsers(
                                items: items, spaceDocId: data.id);
                          },
                          childCount: snapshot.data?.docs.length,
                        ),
                      ),
                      const SliverPadding(
                        padding: EdgeInsets.only(bottom: 40),
                      ),
                    ],
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      ShimmerWidget(),
                    ],
                  ),
                );
              },
            )
          ),
        ),






        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const CreateItem());
          },
          backgroundColor: AppColor.primaryColor,
          child: const Icon(
            Icons.add,
            color: AppColor.tertiaryColor,
            size: 30.0,
          ),
        ),
      ),
    );
  }





  ///TODO - LOAD ACTUAL DATA
  Widget dummyUI() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ///DUMMY MAPS PHOTO
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: AppColor.dark,
                    ),
                    child: Image.asset(
                      AppImages.mapsDummy,
                      fit: BoxFit.fill,
                      //height: ScreenSize.height(context) * 0.3,
                      width: ScreenSize.width(context) * 0.95,
                    ),
                  ),

                  ///LIVE
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5, bottom: 5),
                      decoration: const BoxDecoration(
                        color: AppColor.red,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: const AutoSizeText(
                        "LIVE",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.dark),
                      ),
                    ),
                  ),
                ],
              ),

              ///INFO LIST TILE
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                child: ListTile(
                    shape: const Border(
                        bottom: BorderSide(
                            color: AppColor.greyShimmer,
                            style: BorderStyle.solid)),
                    title: const Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: AutoSizeText(
                        "Garbage Collector will arrive in 45 Minutes",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 5),
                      //ORDER TOTAL AND INCLUSIVE OF ALL GST - LABEL
                      child: RichText(
                        maxLines: 2,
                        text: const TextSpan(
                          text: "Driver Name - Raju : Phone - 9988998800",
                          style: TextStyle(
                              color: AppColor.blackMild,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[],
                        ),
                      ),
                    ),

                    ///PURCHASE BUTTON
                    trailing: IconButton(
                      color: AppColor.primaryColor,
                      onPressed: (){
                        launchController.makePhoneCall(phoneNumber: "9988998800");
                      },
                      icon:const Icon(Icons.phone,color: AppColor.primaryColor,),
                    )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}

class ListItemViewUsers extends StatefulWidget {
  const ListItemViewUsers(
      {Key? key, required this.items, required this.spaceDocId})
      : super(key: key);
  final Notifications items;
  final String spaceDocId;

  @override
  State<ListItemViewUsers> createState() => _ListItemViewUsersState();
}

class _ListItemViewUsersState extends State<ListItemViewUsers> {
  late ExpandedTileController expandedController;

  @override
  void initState() {
    // initialize controller
    expandedController = ExpandedTileController(isExpanded: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listItemComponent(spaces: widget.items);
  }

  ///RETURNS LIST ITEM VIEW
  Widget listItemComponent({required Notifications spaces}) {
    return GestureDetector(
      onTap: () async {

      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: AppColor.greyLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 10.0,
          child: ListBody(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: ListTile(
                  isThreeLine: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(1),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Icon(
                          Icons.recycling,
                          size: 35.0,
                          color: AppColor.greyLight.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),

                  ///SPACE NAME
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: AutoSizeText(
                      spaces.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black
                      ),
                    ),
                  ),

                  ///SPACE DESCRIPTION - SPACE CAPACITY
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 5),
                    child: AutoSizeText(
                     "Area : ${widget.items.area}\nTime : ${DateFormat().add_jm().format(widget.items.time.toDate())}" ??
                          "",
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                          color: AppColor.black

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ERROR PAGE - SHOWING NO SPACES ERROR
class NoSpacesErrorPage extends StatefulWidget {
  const NoSpacesErrorPage({Key? key}) : super(key: key);

  @override
  State<NoSpacesErrorPage> createState() => _NoSpacesErrorPageState();
}

class _NoSpacesErrorPageState extends State<NoSpacesErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: ScreenSize.height(context) * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.recycling,
                  size: 100,
                  color: AppColor.primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 60),
                  child: Text(
                    'NO UPDATES',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


