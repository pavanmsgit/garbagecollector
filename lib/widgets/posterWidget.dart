import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




import '../const/appColors.dart';
import '../const/screen_size.dart';
import '../controllers/posterController.dart';
import '../models/posters.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: posterController.getPosters(),
      builder: (ctx, snapshot) {
        return posterObjects(context);
      },
    );
  }
}

posterObjects(context) {
  List<Posters> posterList = posterController.poster;

  final List<Widget> contentSliders = posterList
      .map(
        (item) => Card(
      color: AppColor.primaryColor,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(
              item.posterLink,
              width: ScreenSize.width(context),
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              alignment: Alignment.center,
              width: ScreenSize.width(context) * 0.8,
              padding: const EdgeInsets.all(5.0),
              child: AutoSizeText(
                item.posterDescription,
                maxLines: 2,
                style: const TextStyle(
                    color: AppColor.dark,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    ),
  )
      .toList();

  return Container(
    padding: const EdgeInsets.only(top: 0),
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        aspectRatio: 2,
        enlargeCenterPage: true,
        disableCenter: false,
        scrollPhysics: const BouncingScrollPhysics(),
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
      items: contentSliders,
    ),
  );
}
