import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garbagecollector/const/appColors.dart';
import 'package:garbagecollector/controllers/itemsController.dart';
import 'package:garbagecollector/widgets/appBars.dart';
import 'package:garbagecollector/widgets/appButtons.dart';
import 'package:garbagecollector/widgets/spinner.dart';
import 'package:garbagecollector/widgets/titleTextField.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({Key? key}) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Spinner(
        child: Scaffold(
          appBar: titleAppBarWithBackButton(title: "ADD INFO", subTitle: '', context: context),
          backgroundColor: AppColor.tertiaryColor,
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: GetBuilder(
              init: ItemsController(),
              builder: (_) => Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Form(
                  key: itemsController.createSpaceKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [

                            const SizedBox(height: 20),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: AppColor.primaryColor)),
                                ),

                                child: Column(children: [
                                  DropdownSearch<String>(
                                    popupProps: const PopupProps.menu(

                                      searchFieldProps: TextFieldProps(
                                        cursorColor: AppColor.primaryColor,
                                        decoration: InputDecoration(
                                          labelText: "Area",
                                          labelStyle: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.grey,
                                          ),
                                          fillColor: AppColor.primaryColor,
                                          border: InputBorder.none,
                                          hintText: "Areas",
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.grey,
                                          ),
                                        ),
                                      ),
                                      showSelectedItems: true,
                                      showSearchBox: false,
                                      searchDelay: Duration(microseconds: 0),
                                    ),
                                    items: const ["Malleshwaram", "Koramangala","Kanakapura", "Dommasandra", "Electronic City", "Hebbal", "AECS Layout"],

                                    selectedItem: itemsController.selectedArea,
                                    dropdownButtonProps: const DropdownButtonProps(
                                      color: AppColor.primaryColor,
                                      highlightColor: AppColor.primaryColor,
                                    ),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(

                                      baseStyle: TextStyle(color: AppColor.black),
                                      dropdownSearchDecoration: InputDecoration(

                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        hintText: "Areas",
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: AppColor.grey,
                                        ),
                                        labelText: "Areas",
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: AppColor.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white70,
                                        enabledBorder: InputBorder.none,
                                      ),

                                    ),
                                    onChanged: (x) {
                                      itemsController.selectedArea = x!;
                                    },
                                  ),
                                ],
                                ),
                              ),
                            ),


                            const SizedBox(
                              height: 10,
                            ),
                            TitleTextField(
                              showTitle: true,
                              title: 'Title',
                              hint: 'Title',
                              controller: itemsController.spaceNameController,
                              node: itemsController.spaceNameNode,
                              onSubmit: (value) => itemsController
                                  .spaceDescriptionNode
                                  .requestFocus(),
                            ),


                            TitleTextField(
                              showTitle: true,
                              title: 'Description',
                              hint: 'Description',
                              len: 50,
                              controller:
                                  itemsController.spaceDescriptionController,
                              node: itemsController.spaceDescriptionNode,
                              onSubmit: (value) => itemsController
                                  .spaceCapacityNode
                                  .requestFocus(),
                            ),



                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      TaskMastersButton(
                        buttonText: "Create",
                        onTap: () => itemsController.createItem(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
