import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:why_not_143_team/constant.dart/color_constant.dart';
import 'package:why_not_143_team/constant.dart/text_style.dart';
import 'package:why_not_143_team/route/route_constant.dart';
import 'package:why_not_143_team/screens/form_page.dart';
import 'package:why_not_143_team/services/firebase_auth_method.dart';

import '../constant.dart/string.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double? screenHeight, screenWidth;
  bool openMenu = false;
  int defaultChoiceIndex = 0;
  final List<String> _choicesList = ['Tümü', 'Kedi', 'Köpek'];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          menu(context),
          dashboard(context),
        ],
      )),
    );
  }

  _homeAppBar() {
    return AppBar(
      leadingWidth: 80,
      backgroundColor: ColorConstant.instance.lightGray,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          setState(() {
            openMenu = !openMenu;
          });
        },
        icon: Icon(
          Icons.menu,
          color: ColorConstant.instance.yankeBlue,
        ),
      ),
      centerTitle: true,
      title: Text(StringConstant.instance.homePage,
          style: GoogleFonts.poppins(color: ColorConstant.instance.yankeBlue)),
    );
  }

  Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      top: openMenu ? 0.1 * screenHeight! : 0,
      bottom: openMenu ? 0.2 * screenWidth! : 0,
      left: openMenu ? 0.5 * screenWidth! : 0,
      duration: const Duration(milliseconds: 500),
      child: Material(
        color: ColorConstant.instance.white,
        elevation: 15,
        borderRadius:
            openMenu ? const BorderRadius.all(Radius.circular(20)) : null,
        child: SingleChildScrollView(child: _homeBody(context)),
      ),
    );
  }

  SizedBox _homeBody(BuildContext context) {
    return SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _homeAppBar(),
                    const _SearchWidget(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => FormPage())));
                        },
                        child: Text("form")),

                    /*const _SearchWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 25),
                  child: Wrap(
                    spacing: 8,
                    children: List.generate(_choicesList.length, (index) {
                      return ChoiceChip(
                        labelPadding: const EdgeInsets.all(2.0),
                        label: Text(_choicesList[index],
                            style: TextStyleConstant
                                .instance.textSmallMedium
                                .copyWith(
                                    color: ColorConstant.instance.white)),
                        selected: defaultChoiceIndex == index,
                        selectedColor: ColorConstant.instance.yankeBlue,
                        onSelected: (value) {
                          setState(() {
                            defaultChoiceIndex =
                                value ? index : defaultChoiceIndex;
                          });
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        elevation: 0,
                      );
                    }),
                  ),
                ),
              ],
                )),*/
                    /*Column(
              children: [
                //TODO: Hayvanlar listesi, geçici liste

                SizedBox(
              height: 250.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Image.asset(AssetPath.instance.coverImage),
                  Image.asset(AssetPath.instance.coverImage),
                  Image.asset(AssetPath.instance.coverImage),
                  Image.asset(AssetPath.instance.coverImage),
                ],
              ),
                ),
                SizedBox(
              height: 10.h,
                ),
                const _SocialCard()
              ],
            )*/
                  ])
            ]));
  }

  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        height: screenHeight,
        color: ColorConstant.instance.white,
        child: Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  MenuItem(
                    icons: Icons.info_outline,
                    text: StringConstant.instance.menuAbout,
                    page: RouteConstant.homeScreenRoute,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  MenuItem(
                    icons: Icons.send,
                    text: StringConstant.instance.menuSendBack,
                    page: RouteConstant.homeScreenRoute,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  MenuItem(
                    icons: Icons.star,
                    text: StringConstant.instance.menuRateOurApp,
                    page: RouteConstant.homeScreenRoute,
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<FirebaseAuthMethods>()
                              .signOut(context)
                              .then((value) => Navigator.pushNamed(
                                  context, RouteConstant.coverScreenRoue));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: ColorConstant.instance.yankeBlue,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                StringConstant.instance.logOut,
                                style:
                                    TextStyleConstant.instance.textLargeRegular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

//TODO: Responsive
/* class _SocialCard extends StatelessWidget {
  const _SocialCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 200.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 70.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConstant.instance.yankeBlue,
                ColorConstant.instance.yankeBlue.withOpacity(0.5),
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringConstant.instance.homeSocialText,
              style: TextStyleConstant.instance.textSmallMedium
                  .copyWith(color: ColorConstant.instance.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 5.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConstant.instance.white)),
              child: Text(
                "Katıl",
                style: TextStyleConstant.instance.textSmallMedium
                    .copyWith(color: ColorConstant.instance.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: StringConstant.instance.searchText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.instance.black)),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icons;
  final String page;
  const MenuItem(
      {Key? key, required this.text, required this.icons, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, page);
      },
      child: Row(
        children: [
          Icon(
            icons,
            color: ColorConstant.instance.yankeBlue,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyleConstant.instance.textLargeRegular,
            ),
          ),
        ],
      ),
    );
  }
}
