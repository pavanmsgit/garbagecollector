import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garbagecollector/const/appColors.dart';
import 'package:garbagecollector/const/screen_size.dart';
import 'package:garbagecollector/controllers/authController.dart';
import 'package:garbagecollector/controllers/launch_controller.dart';
import 'package:garbagecollector/widgets/appBars.dart';
import 'package:garbagecollector/widgets/appDialogs.dart';

import 'accountsComponents/editMyAccount.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.tertiaryColor,
        body: GetBuilder(
            init: AuthController(),
            builder: (_) =>

                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBarLogo(title: "My Account",),

                    SliverToBoxAdapter(
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        elevation: 3.0,
                        child: ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          //tileColor: AppColor.primaryColor.withOpacity(0.2),
                          horizontalTitleGap: 20,
                          leading: authController.profile!.profileImage == "" ? Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child:  const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: AppColor.dark,
                                )
                            ),
                          ) : Container(
                            color: AppColor.greyLight,
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child:  Image.network(
                                  authController.profile!.profileImage,
                                  height: ScreenSize.height(context) * 0.1,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                          title: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text(
                                  authController.profile!.name,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),

                          subtitle: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 5),
                                  child: Text(
                                    "${authController.profile!.email}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          trailing: IconButton(
                              icon: const Icon(Icons.edit,color: AppColor.primaryColor,),
                              onPressed: () {
                                Get.to(
                                      () =>const EditMyAccount(),
                                );
                              }
                          ),
                        ),
                      ),
                    ),

                    //LIST OF OPTIONS
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),




                          //MANAGE MARKETPLACE




                          AccountTile(
                              iconData: Icons.report,
                              title: 'Report An Issue',
                              onTap: () {
                                launchController.launchEmailForReportAnIssue();
                              }
                          ),


                          AccountTile(
                              iconData: Icons.help,
                              title: 'Help',
                              onTap: () {
                                launchController.launchEmailForHelp();
                              }
                          ),

                          AccountTile(
                            iconData: Icons.logout,
                            //iconColor: AppColor.red,
                            title: 'Logout',
                            onTap: () {
                              yesNoDialog(text:
                                'Do you want to logout?', context: context, onTap: () {authController.logoutUser(); },
                              );
                            },
                          ),

                          // AccountTile(
                          //   iconData: Icons.delete,
                          //   //iconColor: AppColor.red,
                          //   title: 'Delete Account',
                          //   onTap: () {
                          //     yesNoDialog(
                          //         context,
                          //         'Are you sure, you want to delete the account?',
                          //             (){userController.deleteUserAccount();});
                          //   },
                          // ),


                        ],
                      ),
                    ),

                  ],
                )
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSize.height(context) * 0.05,
        margin: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 6,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.tertiaryColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.tertiaryColor.withOpacity(0.0),
              blurRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: AppColor.primaryColor,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColor.dark,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}



