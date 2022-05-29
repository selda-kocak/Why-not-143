import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:why_not_143_team/meta/helper/constant/color_constant.dart';
import 'package:why_not_143_team/meta/widget/card_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSlider extends StatefulWidget {
  const CardSlider({Key? key}) : super(key: key);

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  int _currentIndex = 0;
  List cardList = [
    const CardItem(text: "Pati Rehberi Keşfedin", buttonText: "Keşfet"),
    const CardItem(text: "Pati Forumu Keşfet", buttonText: "Keşfet"),
    const CardItem(text: "Patilerimize Bağış Yapın", buttonText: "Bağış Yap"),
    const CardItem(
        text: "Patiler için sosyal sorumluluk\nprojelerine katıl",
        buttonText: "Keşfet")
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: cardList.map((card) {
            return Builder(builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset:
                            const Offset(4, 4), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                  child: card,
                ),
              );
            });
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(cardList, (index, url) {
            return Container(
              width: 10.0.w,
              height: 7.0.h,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? ColorConstant.instance.orange.withOpacity(0.5)
                      : ColorConstant.instance.neutral300),
            );
          }),
        ),
      ],
    );
  }
}
