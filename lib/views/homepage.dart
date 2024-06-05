import 'package:dokan/components/constants/app_colors.dart';
import 'package:dokan/components/constants/app_icons.dart';
import 'package:dokan/components/global_widget/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int bodyIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeBody(bodyIndex),
      floatingActionButton: fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar(),
    );
  }

  BottomAppBar bottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
      height: 65,
      color: AppColors.whiteBg,
      elevation: 25,
      shadowColor: Colors.black,
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: AppIcon(
              AppIcons.home,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 0;
                });
              }
            },
          ),
          IconButton(
            icon: AppIcon(
              AppIcons.dashboard,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 1;
                });
              }
            },
          ),
          SizedBox(width: 48), // Spacer for the FAB
          IconButton(
            icon: AppIcon(
              AppIcons.cart,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 2;
                });
              }
            },
          ),
          IconButton(
            icon: AppIcon(
              AppIcons.person,
              size: 24,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  bodyIndex = 3;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Container fab() {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF679B),
            Color(0xFFFF7B51),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFB82D48).withOpacity(0.15),
            offset: Offset(0, 12),
            blurRadius: 28,
          ),
        ],
      ),
      child: RawMaterialButton(
        shape: CircleBorder(),
        onPressed: () {},
        child: AppIcon(
          AppIcons.search,
          color: AppColors.whiteText,
          size: 24,
        ),
      ),
    );
  }
}

Widget homeBody(int index) {
  switch (index) {
    case 0:
      return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(30),
                  Text(
                    'Product List',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      height: 25,
                      width: 25,
                      child: AppIcon(AppIcons.search),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 1.sw,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          productContainer(),
                          productContainer(),
                          productContainer(),
                          productContainer(),
                          productContainer(),
                          productContainer(),
                          productContainer(),
                          productContainer(),
                          productContainer(),
                        ],
                      ),
                    ),
                    Gap(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    case 1:
      return Container();
    case 2:
      return Container();
    case 3:
      return Container();
    default:
      return Container();
  }
}

Container productContainer() {
  return Container(
    width: ScreenUtil().screenWidth < 600 ? .43.sw : .28.sw,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: AppColors.whiteBg,
      boxShadow: [
        BoxShadow(
          blurRadius: 6,
          color: AppColors.shadowColor.withOpacity(.13),
          offset: const Offset(2, 3),
        )
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/Bitmap.png',
            width: ScreenUtil().screenWidth < 600 ? .43.sw : .28.sw,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Man Stylish Dresses…\n',
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Text(
                        '\$550',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyText,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Gap(3),
                      Text(
                        '\$789',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  itemSize: 17,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Gap(5),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
