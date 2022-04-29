import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:why_not_143_team/constant.dart/asset_path.dart';

import '../constant.dart/color_constant.dart';
import '../constant.dart/padding_constant.dart';
import '../constant.dart/string.dart';
import '../constant.dart/text_style.dart';
import 'home_page.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  double opacityLevel = 1.0;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      onDone: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      pages: getPages(),
      showNextButton: true,
      globalBackgroundColor: ColorConstant.instance.white,
      showSkipButton: true,
      skip: const _SkipButton(),
      next: const _NextButton(),
      done: const _DoneButton(),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: _dotsDecorater(),
    ));
  }

  DotsDecorator _dotsDecorater() {
    return DotsDecorator(
      activeColor: ColorConstant.instance.yankeBlue,
      size: const Size(10.0, 10.0),
      activeSize: const Size(20.0, 10.0),
      activeShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        titleWidget: const Text(""),
        bodyWidget: Padding(
          padding: PaddingConstant.instance.onBoardPadding,
          child: _OnBoardBodyWidget(
            title: StringConstant.instance.onBoardTitle1,
            subTitle: StringConstant.instance.onBoardSubTitle1,
            path: AssetPath.instance.onBoardImage1,
            opacityLevel: opacityLevel,
            visible: visible,
          ),
        ),
        decoration: _pageDecorationWidget(),
      ),
      PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Padding(
            padding: PaddingConstant.instance.onBoardPadding,
            child: _OnBoardBodyWidget(
              title: StringConstant.instance.onBoardTitle2,
              subTitle: StringConstant.instance.onBoardSubTitle2,
              path: AssetPath.instance.onBoardImage2,
              opacityLevel: opacityLevel,
              visible: visible,
            ),
          ),
          decoration: _pageDecorationWidget()),
      PageViewModel(
          titleWidget: const Text(""),
          bodyWidget: Padding(
            padding: PaddingConstant.instance.onBoardPadding,
            child: _OnBoardBodyWidget(
              title: StringConstant.instance.onBoardTitle3,
              subTitle: StringConstant.instance.onBoardSubTitle3,
              path: AssetPath.instance.onBoardImage3,
              opacityLevel: opacityLevel,
              visible: visible,
            ),
          ),
          decoration: _pageDecorationWidget()),
    ];
  }

  PageDecoration _pageDecorationWidget() {
    return PageDecoration(
      imageAlignment: Alignment.bottomCenter,
      bodyTextStyle: TextStyleConstant.instance.textSmallRegular
          .copyWith(color: ColorConstant.instance.black),
      bodyAlignment: Alignment.center,
      bodyFlex: 2,
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      width: 62.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: ColorConstant.instance.yankeBlue),
      child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: Icon(
            Icons.done,
            color: ColorConstant.instance.white,
          )),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      width: 62.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: ColorConstant.instance.yankeBlue),
      child: Icon(
        Icons.arrow_forward,
        color: ColorConstant.instance.white,
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: Text(StringConstant.instance.onBoardPass,
            style: TextStyleConstant.instance.textLargeMedium
                .copyWith(color: ColorConstant.instance.yankeBlue)));
  }
}

class _OnBoardBodyWidget extends StatelessWidget {
  final String path;
  final String title;
  final String subTitle;
  const _OnBoardBodyWidget(
      {Key? key,
      required this.opacityLevel,
      required this.visible,
      required this.title,
      required this.subTitle,
      required this.path})
      : super(key: key);

  final double opacityLevel;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 250.h,
        child: IgnorePointer(
          child: AnimatedOpacity(
            opacity: opacityLevel,
            duration: const Duration(seconds: 200),
            child: _ImageCard(
              image: AssetImage(path),
            ),
          ),
          ignoring: !visible,
        ),
      ),
      SizedBox(
        height: 32.h,
      ),
      Center(
          child: Text(
        title,
        style: TextStyleConstant.instance.title1
            .copyWith(color: ColorConstant.instance.yankeBlue),
      )),
      SizedBox(
        height: 32.h,
      ),
      Text(
        subTitle,
        style: TextStyleConstant.instance.textSmallMedium
            .copyWith(color: ColorConstant.instance.neutral),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}

class _ImageCard extends StatelessWidget {
  final ImageProvider image;
  const _ImageCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.contain)),
    );
  }
}
